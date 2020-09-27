// Linear Feedback Shift Register of 10 bits using XNORs
// Source for where to put the XNORs: 
// LFSR taps [XAPP 052 July 7, 1996 (Version 1.1), Peter Alfke, Xilinx Inc]. 

// This will produce a 10-bit patter in the signal Q that is pseudo-random. 
// i.e.: It is a deterministic machine, but there are many states and it is hard to figure out the pattern. 
// Q will take all binary values between 10'b0 (inclusive) and 10'b111111111 (exclusive).

// Source claims that XNOR lsfrs won't sequence thorugh the state where all values are 1: 
// https://www.eetimes.com/tutorial-linear-feedback-shift-registers-lfsrs-part-1/#

// This machine does not need a reset, since A becomes 0 when Q[i]=1 for all valid i (prevents getting stuck on startup)
// To not use reset, let reset be always FALSE

module lsfr10(Q, clk, reset);
	output logic [9:0] Q;
	input logic clk, reset;	
	logic A;
	
	// prevents getting stuck. If Q[i] is TRUE for every valid i, then it will let A=0 to get out of of that state
	// prevents getting stuck on that state on startup
	always_comb begin
		if(Q[0] && Q[1] && Q[2] && Q[3] && Q[4] && Q[5] && Q[6] && Q[7] && Q[8] && Q[9]) A = 1'b0;
		else A = Q[7] ~^ Q[9];
	end
	
	D_FF DFF0(.d(A), 		.q(Q[0]), .reset(reset), .clk);
	D_FF DFF1(.d(Q[0]), 	.q(Q[1]), .reset(reset), .clk);
	D_FF DFF2(.d(Q[1]), 	.q(Q[2]), .reset(reset), .clk);
	D_FF DFF3(.d(Q[2]), 	.q(Q[3]), .reset(reset), .clk);
	D_FF DFF4(.d(Q[3]), 	.q(Q[4]), .reset(reset), .clk);
	D_FF DFF5(.d(Q[4]), 	.q(Q[5]), .reset(reset), .clk);
	D_FF DFF6(.d(Q[5]), 	.q(Q[6]), .reset(reset), .clk);
	D_FF DFF7(.d(Q[6]), 	.q(Q[7]), .reset(reset), .clk);
	D_FF DFF8(.d(Q[7]), 	.q(Q[8]), .reset(reset), .clk);
	D_FF DFF9(.d(Q[8]), 	.q(Q[9]), .reset(reset), .clk);
	
endmodule

module lsfr10_testbench();
	logic [9:0] Q;
	logic clk;
	logic reset;
	
	lsfr10 dut (.Q, .clk, .reset);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		for(integer i = 0; i < 1500; i++) begin
			@(posedge clk);
		end
		$stop;					
	end
endmodule