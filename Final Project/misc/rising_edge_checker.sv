/* Detects rising edges in a signal
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		in						- input signal that will be checked for rising edges
 *
 * Outputs:
 *   	out					- HIGH when a rising edge is detected, otherwise LOW 
 */
module rising_edge_checker(in, out, reset, clk);
	input logic in, reset, clk;
	output logic out;
	
	// possible states of this FSM
	enum {IDLE, FIRST_PRESS, BEING_HELD} ps, ns;
	
	// state transitions
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns; 
	end // always_ff
	
	always_comb begin
		case(ps)
			IDLE: begin
				if(in) ns = FIRST_PRESS;
				else ns = IDLE;
			end // IDLE
			
			FIRST_PRESS: begin
				if(in) ns = BEING_HELD;
				else ns = IDLE;
			end // FIRST_PRESS
			
			BEING_HELD: begin
				if(in) ns = BEING_HELD;
				else ns = IDLE;
			end // BEING_HELD
			
			default: begin
				ns = IDLE;
			end // default
		
		endcase // case(ps)
	end // always_comb
	
	assign out = (ps == FIRST_PRESS);
	
endmodule // rising_edge_checker

/* testbench for rising_edge_checker */
module rising_edge_checker_testbench();
	logic in, reset, clk;
	logic out;
	
	rising_edge_checker dut (.*);
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		in <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		in <= 1'b0;
		@(posedge clk);
		in <= 1'b1;
		repeat (3) @(posedge clk);
		in <= 1'b0;
		repeat (3) @(posedge clk);
		in <= 1'b1;
		@(posedge clk);
		in <= 1'b0;
		repeat (3) @(posedge clk);
		
		$stop;
	end // initial
	
endmodule // rising_edge_checker