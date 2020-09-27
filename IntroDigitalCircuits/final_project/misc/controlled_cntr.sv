// Counter that increases or decreases based on two signals
// incr: if TRUE, increase out. Otherwise, don't
// decr: if TRUE, decrease out. Otherwise, don't
// a combination of both incr and decr TRUE doesnt make any changes
// out: The output of the counter
// In flappy bird, this module keeps track of the height of the bird
module controlled_cntr(reset, clk, out, incr, decr);
	input logic reset, clk, incr, decr;
	output logic [3:0] out;
	
	always_ff @(posedge clk) begin
		if(reset) out <= 4'b1000;
		else if(incr && decr) out <= out;
		else if(incr && ~decr) out <= (out + 4'b0001);
		else if(~incr && decr) out <= (out - 4'b0001);
		else if(~incr && ~decr) out <= out;
	end
	
endmodule

module controlled_cntr_testbench();
	logic reset, clk, incr, decr;
	logic [3:0] out;
	
	controlled_cntr dut (.reset, .clk, .out, .incr, .decr);
	
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
		incr <= 0;
		decr <= 0;
		
		@(posedge clk);
		reset <= 0;
		
		// tests nothing going on
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		// tests increments
		incr <= 1;
		for(integer i = 0; i < 20; i++) begin
			@(posedge clk);
		end
		
		// tests decrements
		incr <= 0;
		decr <= 1;
		for(integer i = 0; i < 20; i++) begin
			@(posedge clk);
		end
		decr <= 1;
		incr <= 1;
		
		// tests both increments and decrements
		for(integer i = 0; i < 20; i++) begin
			@(posedge clk);
		end
		
		$stop;
		
	end
	
endmodule