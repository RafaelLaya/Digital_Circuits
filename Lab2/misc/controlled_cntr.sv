/* Controlled counter based on an increase signal. Upcounts from 0 to N
 * incluse. Width should be enough to hold an unsigned number as big or more
 * than N.
 * 
 * Inputs:
 *   clk        - 1-bit clock signal
 *   reset      - 1-bit reset signal
 *   inc        - 1-bit Increase signal to increase the counter
 *                (synchronized to clk)
 *
 * Outputs:
 *   count      - Unsgined Number of width 'WIDTH' that represents the current count.
 *                Increases on the clock edge based on inc. Counts from 0 to N
 *   expired    - Asserted TRUE when count wraps from N to 0
 *  
 * This top-level module provides the user the ability to read a memory 
 * by manually moving switches.
*/

module controlled_cntr #(parameter WIDTH=32, N=10) (clk, reset, inc, count, expired);
	input logic clk, reset, inc; 
	output logic [WIDTH-1:0] count;
	output logic expired; 
	
	always_ff @(posedge clk) begin
		if(reset) count <= 'b0;
		else if (inc) begin
			if(count == N) count <= 'b0;
			else count <= count + 1;
		end // else if(inc)
		else count <= count;
	end // always_ff
	
	always_ff @(posedge clk) begin
		if(reset) expired <= 1'b0;
		else if (inc) expired <= (count == N);
		else expired <= 1'b0; 
	end // a;ways_ff
	
endmodule // counter

/* testbench for controlled_cntr */
`timescale 1 ps / 1 ps
module controlled_cntr_testbench();
	parameter WIDTH = 4;
	parameter N = 10;
	parameter CLOCK_PERIOD = 100;
	logic clk, reset, inc;
	logic [WIDTH-1:0] count;
	logic expired;
	
	controlled_cntr #(.WIDTH(WIDTH), .N(N)) dut (.clk, .reset, .inc, .count, .expired);

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
		// reset system to a known state
		reset <= 1'b1;
		inc <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// test inc idle
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		// count to N
		for(integer i = 0; i < N; i++) begin
			inc <= 1'b1;
			@(posedge clk);
		end // for
		
		inc <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		// expire the counter and try again
		for(integer i = 0; i < N + 2; i++) begin
			inc <= 1'b1;
			@(posedge clk);
		end // for
		
		inc <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // controlled_cntr_testbench