//module lsfr3(Q1, Q2, Q3, clk, reset);
//	input logic clk, reset;
//	
//	output logic Q1, Q2, Q3;
//	logic A;
//	
//	assign A = Q2 ~^ Q3;
//	D_FF DFF0(.reset, .clk, .d(A), .q(Q1));
//	D_FF DFF2(.reset, .clk, .d(Q1), .q(Q2));
//	D_FF DFF3(.reset, .clk, .d(Q2), .q(Q3));
//	
//endmodule
//
//module lsfr3_testbench();
//	logic clk, reset;
//	logic Q1, Q2, Q3;
//	
//	lsfr3 dut (.clk, .reset, .Q1, .Q2, .Q3);
//	
//	parameter PERIOD = 100;
//	
//	initial begin
//		clk <= 0;
//		forever begin
//			#(PERIOD / 2);
//			clk <= ~clk;
//		end
//	end
//	
//	initial begin
//		reset <= 1;		@(posedge clk);
//		reset <= 0;		@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							@(posedge clk);
//							
//		$stop;
//	end
//	
//endmodule


module lsfr3(Q, clk, reset);
	input logic clk, reset;
	
	output logic [2:0] Q;
	logic A;
	
	assign A = Q[1] ~^ Q[2];
	D_FF DFF0(.reset, .clk, .d(A), .q(Q[0]));
	D_FF DFF2(.reset, .clk, .d(Q[0]), .q(Q[1]));
	D_FF DFF3(.reset, .clk, .d(Q[1]), .q(Q[2]));
	
endmodule

module lsfr3_testbench();
	logic clk, reset;
	logic [2:0] Q;
	
	lsfr3 dut (.clk, .reset, .Q);
	
	parameter PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever begin
			#(PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							
		$stop;
	end
	
endmodule