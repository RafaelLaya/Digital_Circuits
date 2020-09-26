/* Implements a linear feedback shift register of 10 bits with XNORs
 *
 * Inputs:
 *   	clk			- clock signal
 *		reset			- active-high reset signal
 *
 * Outputs:
 *		Q				- output of the linear feedback shift register
 *
 * Does not need a reset since a multiplexer takes the machine out of invalid states
 */

module lsfr10(Q, clk, reset);
	output logic [9:0] Q;
	input logic clk, reset;	
	
	// feedback
	logic A;
	
	// prevents getting stuck. If Q[i] is TRUE for every valid i, then it will let A=0 to get out of of that state
	// prevents getting stuck on that state on startup
	always_comb begin
		if(Q[0] && Q[1] && Q[2] && Q[3] && Q[4] && Q[5] && Q[6] && Q[7] && Q[8] && Q[9]) A = 1'b0;
		else A = Q[6] ~^ Q[9];
	end // always_comb
	
	D_FF DFF0(.in(A), 		.out(Q[0]), .reset(reset), .clk);
	D_FF DFF1(.in(Q[0]), 	.out(Q[1]), .reset(reset), .clk);
	D_FF DFF2(.in(Q[1]), 	.out(Q[2]), .reset(reset), .clk);
	D_FF DFF3(.in(Q[2]), 	.out(Q[3]), .reset(reset), .clk);
	D_FF DFF4(.in(Q[3]), 	.out(Q[4]), .reset(reset), .clk);
	D_FF DFF5(.in(Q[4]), 	.out(Q[5]), .reset(reset), .clk);
	D_FF DFF6(.in(Q[5]), 	.out(Q[6]), .reset(reset), .clk);
	D_FF DFF7(.in(Q[6]), 	.out(Q[7]), .reset(reset), .clk);
	D_FF DFF8(.in(Q[7]), 	.out(Q[8]), .reset(reset), .clk);
	D_FF DFF9(.in(Q[8]), 	.out(Q[9]), .reset(reset), .clk);
	
endmodule // lsfr10

/* testbench for lsfr10 */
module lsfr10_testbench();
	logic [9:0] Q;
	logic clk;
	logic reset;
	
	lsfr10 dut (.Q, .clk, .reset);
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		for(integer i = 0; i < 1500; i++) begin
			@(posedge clk);
		end
		$stop;					
	end // initial
endmodule // lsfr10