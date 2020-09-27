/* Parametrizable synchronizer
 * 
 * Inputs:
 *   in    - SIZE-bit input signal to be synchronized
 *   reset - 1-bit reset signal
 *   clk   - 1-bit clock signal

 *
 * Outputs:
 *   out   - SIZE-bit output signal synchronized version of input
 *  
 * Very often used to synchronize external inputs to avoid
 * meta-stability. 
*/

module synchronizer #(parameter SIZE=1) (in, out, clk, reset);
	input logic [SIZE-1:0] in;
	output logic [SIZE-1:0] out;
	input logic clk, reset;
	
	logic [SIZE-1:0] middle;
	
	genvar i;
	generate
		for (i = 0; i < SIZE; i++) begin : eachPairDFFs
			D_FF dff1 (.out(middle[i]), .in(in[i]), .reset(reset), .clk(clk));
			D_FF dff2 (.out(out[i]), .in(middle[i]), .reset(reset), .clk(clk));
		end // for
	endgenerate // generate
	
endmodule // synchronizer

/* testbench for synchronizer */
module synchronizer_testbench();
	parameter SIZE = 8;
	logic [SIZE-1:0] in;
	logic [SIZE-1:0] out;
	logic clk, reset;
	parameter CLOCK_PERIOD = 100;
	synchronizer #(.SIZE(SIZE)) dut (.in(in), .out(out), .clk(clk), .reset(reset));
	
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
		in <= 'b0; 
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		
		// test a few inputs 
		for(integer i = 0; i < 16; i++) begin
			in <= i;
			@(posedge clk);
		end // for
		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
	
endmodule // synchronizer_testbench