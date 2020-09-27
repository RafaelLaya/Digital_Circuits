/* Controller for a bit counter module. Counts bits set in an 8-bits input 
 *
 * Inputs:
 *   clk				- 1-bit clock signal
 *   reset			- 1-bit active-high synchronous reset signal
 *   start			- 1-bit active-high start signal to initiate the bit counting
 *   a0				- 1-bit status signal that represents the least-significant bit in the
 *                  number that is internally kept by the datapath for counting bits, which is
 *                  a shifted version of the original input number
 *   zero_A			- 1-bit status signal that is TRUE if the internally kept version of the input
 *                  is 0, which signals the end of the algorithm
 *
 * Outputs:
 *   done			- 1-bit active high signal that tells the algorithm has finished
 *   load_A			- 1-bit active-high control signal that tells datapath to take a snapshot of the input number
 *   shift_A		b- 1-bit active-high control signal that tells datapath to right shift the internally kept number
 *   incr_result	- 1-bit active-high control signal that tells datapath to increment the result
 *   clr_result	- 1-bit active-high control signal that tells datapath to clear the result counter
 */
module bit_counter_controller(clk, reset, start, done, load_A, shift_A, incr_result, clr_result, a0, zero_A);
	// external signals
	input logic clk, reset, start;
	output logic done;
	
	// status signals
	input logic a0, zero_A;
	
	// control signals
	output logic load_A, shift_A, incr_result, clr_result;
	
	// internal signals
	enum {IDLE, COMPUTING, FINISHED} ps, ns;
	
	// state-transitions
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	// next-state logic
	always_comb begin
		case(ps) 
			IDLE: begin
				if(start) ns = COMPUTING;
				else ns = IDLE;
			end // IDLE
			
			COMPUTING: begin
				if(zero_A) ns = FINISHED;
				else ns = COMPUTING;
			end // COMPUTING
			
			FINISHED: begin
				if(start) ns = FINISHED;
				else ns = IDLE;
			end // FINISHED
			
			default: begin
				ns = IDLE;
			end // default
		endcase // case(ps)
	end // always_comb
	
	// load_A logic
	always_comb begin
		if((ps == IDLE)) load_A = 1'b1;
		else load_A = 1'b0;
	end // always_comb
	
	// shift_A logic
	always_comb begin
		if(ps == COMPUTING) shift_A = 1'b1;
		else shift_A = 1'b0;
	end // always_comb
	
	// incr_result logic
	always_comb begin
		if((ps == COMPUTING) && (~zero_A) && (a0)) incr_result = 1'b1;
		else incr_result = 1'b0;
	end // always_comb
	 
	// clr_result logic
	always_comb begin
		if(ps == IDLE) clr_result = 1'b1;
		else clr_result = 1'b0;
	end // always_comb
	
	// done logic
	always_comb begin
		if(ps == FINISHED) done = 1'b1;
		else done = 1'b0;
	end // always_comb

endmodule // binary_counter_controller

/* testbench for bit_counter_controller */
module bit_counter_controller_testbench();
	logic clk, reset, start;
	logic done;
	logic a0, zero_A;
	logic load_A, shift_A, incr_result, clr_result;
	
	parameter CLOCK_PERIOD = 100;
	
	bit_counter_controller dut (.*);
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		reset <= 1'b1;
		zero_A <= 1'b0;
		a0 <= 1'b0;
		start <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// 1. The load loop 
		start <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		
		// 2. System starts
		start <= 1'b1;
		@(posedge clk);
		
		// 3. Loop without increase
		zero_A <= 1'b0;
		a0 <= 1'b0;
		@(posedge clk);
		
		// 4. Loop with increase
		zero_A <= 1'b0;
		a0 <= 1'b1;
		@(posedge clk);
		
		// 5. finish
		zero_A <= 1'b1;
		@(posedge clk);
		
		// 6. start loop
		start <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		
		// 7. Goes back to Idle
		start <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end
	
endmodule // binary_counter_testbench