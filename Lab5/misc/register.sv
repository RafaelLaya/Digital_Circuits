/* Parametrized Register
 * 
 * Inputs:
 *   	clk 			- 1-bit clock signal
 *		reset			- 1-bit active-high synchronous reset signal
 *		in  			- N-bits of input data
 *		en				- 1-bit active-high enable signal
 *
 * Output:
 *   	out  			- N-bits of data out
*/
module register #(parameter N=8) (clk, reset, in, out, en);
	input logic clk, reset, en;
	input logic [N-1:0] in;
	output logic [N-1:0] out;
	
	always_ff @(posedge clk) begin
		if(reset) out <= '0;
		else if(en) out <= in;
		else out <= out;
	end // always_ff
endmodule // Register
 
/* testbench for register */ 
module register_testbench();
	parameter N = 8;
	logic clk, reset, en;
	logic [N-1:0] in, out;
	
	parameter CLOCK_PERIOD = 100;
	
	register #(.N(N)) dut (.*);
	
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
		in <= 8'b0;
		en <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// 1. load with enable
		in <= 8'b1010_0101;
		en <= 1'b1;
		@(posedge clk);
		
		// 2. enable off
		en <= 1'b0;
		in <= 8'b0;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // register_testbench