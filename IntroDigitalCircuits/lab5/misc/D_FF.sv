module D_FF(q, d, reset, clk);
	output logic q;
	input logic d, reset, clk;
	
	always_ff @(posedge clk) begin
		if(reset) 
			q <= 0;
		else 
			q <= d;
	end
endmodule

module D_FF_testbench();
	logic q, d, reset, clk;
	
	parameter PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(PERIOD / 2) clk <= ~clk;
		end
	end
	
	D_FF dut(.q, .d, .reset, .clk);
	
	initial begin
		d <= 0;
		reset <= 0;
							@(posedge clk);
		reset <= 1;		@(posedge clk);
							@(posedge clk);
		reset <= 0;		@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		d <= 1;			@(posedge clk);
		d <= 0;			@(posedge clk);
		d <= 1;			@(posedge clk);
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
							@(posedge clk);
		d <= 0;
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		$stop;
	end
endmodule