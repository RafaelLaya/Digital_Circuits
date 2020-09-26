/* Counts the number of SET bits in the input 'in'
 *
 * Inputs:
 *   clk				- 1-bit clock signal
 *   reset			- 1-bit active-high synchronous reset signal
 *	  start			- 1-bit active-high start signal that initiates the computation
 *   in 				- 8-bit input whose bits SET will be counted
 *
 * Outputs:
 *		result		- 4-bit result of the bits counted in 'in' that are SET
 *		done			- 1-bit active-high signal that signals computation is available
 */
module bit_counter(clk, reset, start, in, done, result);
	input logic clk, reset, start;
	input logic [7:0] in;
	output logic done;
	output logic [3:0] result;
	
	logic load_A, shift_A, incr_result, clr_result, a0, zero_A;
	bit_counter_controller controller (.*);
	bit_counter_datapath datapath (.*);

endmodule // bit_counter

/* testbench for bit_counter */
module bit_counter_testbench();
	logic clk, reset, start;
	logic [7:0] in;
	logic done;
	logic [3:0] result;
	
	bit_counter dut (.*);
	
	// set-up clock
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
		reset <= 1'b1;
		start <= 1'b0;
		in <= 8'b0000_0000;
		@(posedge clk);
		reset <= 1'b0;
		
		for (integer i = 0; i < 20; i++) begin
			in <= 8'(i);
			@(posedge clk);
			start <= 1'b1;
			@(posedge clk);
			@(posedge done);
			start <= 1'b0;
			@(posedge clk);
		end // for
		
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end // initial
endmodule // bit_counter_testbench