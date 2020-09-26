/* Datapath for a bit counter module. Counts bits set in an 8-bits input 
 *
 * Inputs:
 *   clk				- 1-bit clock signal
 *   reset			- 1-bit active-high synchronous reset signal
 *   in 				- 8-bit input whose set bits are going to be counted
 *   load_A			- 1-bit active-high control signal that tells datapath to take a snapshot of the input number
 *   shift_A		- 1-bit active-high control signal that tells datapath to right shift the internally kept number
 *   incr_result	- 1-bit active-high control signal that tells datapath to increment the result
 *   clr_result	- 1-bit active-high control signal that tells datapath to clear the result counter
 *
 * Outputs:
 *   a0				- 1-bit status signal that represents the least-significant bit in the
 *                  number that is internally kept by the datapath for counting bits, which is
 *                  a shifted version of the original input number
 *   zero_A			- 1-bit status signal that is TRUE if the internally kept version of the input
 *                  is 0, which signals the end of the algorithm
 *   result			- 4-bit count of the bits set in the given input. The result is valid if the user
 *                  is seeing a TRUE done signal sent by the controller. 

 */
 
module bit_counter_datapath(clk, reset, load_A, shift_A, incr_result, clr_result, a0, zero_A, in, result);
	// external signals
	input logic clk, reset;
	input logic [7:0] in;
	output logic [3:0] result;
	
	// control signals
	input logic load_A, shift_A, incr_result, clr_result;
	
	// status signals
	output logic a0, zero_A;
	
	// internal signals
	logic [7:0] A;
	
	// result logic
	always_ff @(posedge clk) begin
		if(reset) result <= 4'b0000;
		else if(clr_result) result <= 4'b0000;
		else if(incr_result) result <= (result + 4'b0001);
		else result <= result;
	end // always_ff
	
	// a0 logic
	assign a0 = A[0];
	
	// zero_A logic
	assign zero_A = (A == 8'b0000_0000);
	
	// A logic
	always_ff @(posedge clk) begin
		if(reset) A <= 8'b0000_0000;
		else if(load_A) A <= in;
		else if(shift_A) A <= (A >> 1);
		else A <= A;
	end // always_ff

endmodule // bit_counter_datapath

/* testbench for bit_counter_datapath */
module bit_counter_datapath_testbench();
	logic clk, reset;
	logic [7:0] in;
	logic [3:0] result;
	logic load_A, shift_A, incr_result, clr_result;
	logic a0, zero_A;
	
	bit_counter_datapath dut (.*);
	
	parameter CLOCK_PERIOD = 100;
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		reset <= 1'b1;
		in <= 0;
		load_A <= 1'b0;
		shift_A <= 1'b0;
		incr_result <= 1'b0;
		clr_result <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// 1. load_A (and a0)
		in <= 8'b1001_0110;
		load_A <= 1'b1;
		@(posedge clk);
		load_A <= 1'b0;
		
		// 2. shift_A
		shift_A <= 1'b1;
		@(posedge clk);
		shift_A <= 1'b0;
		
		// 3. incr_result
		incr_result <= 1'b1;
		@(posedge clk);
		incr_result <= 1'b0;
		@(posedge clk);
		
		// 4. clr_result
		clr_result <= 1'b1;
		@(posedge clk);
		clr_result <= 1'b0;
		
		// 5. zero_A
		in <= 8'b000_0000;
		load_A <= 1'b1;
		@(posedge clk);
		load_A <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		
		$stop;
		
	end // initial
	
endmodule // bit_counter_datapath_testbench

