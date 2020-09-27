// Represents a single digit in a scoreboard
// bcd: a single digit in bcd format
// incr_in: Increase bcd if TRUE, otherwise dont
// incr_out: Communicates to increase next digit if TRUE, otherwise don't
// 			 This is done when this bcd has to roll back (i.e.: ...->8->9->0 (incr_out == TRUE here))
module score_digit(clk, reset, incr_in, incr_out, bcd);
	input logic clk, reset;
	input logic incr_in;
	output logic incr_out;
	output logic [3:0] bcd;
	
	logic [3:0] count;	
	
	// score logic
	always_ff @(posedge clk) begin
		if(reset) count <= 4'b0000;
		else if(incr_in && count == 4'b1001) count <= 4'b0000;
		else if(incr_in) count <= (count + 4'b0001);
		else count <= count;
	end
	
	// incr_out logic
	always_ff @(posedge clk) begin
		if(reset) incr_out <= 0;
		else if(incr_in && count == 4'b1001) incr_out <= 1;
		else incr_out <= 0;
	end
	
	// bcd is simply count (there is no difference between bcd and unsigned binary numbers for a single digit number
	always_comb begin
		bcd = count;
	end
endmodule

module score_digit_testbench();
	logic clk, reset, incr_in, incr_out;
	logic [3:0] bcd;
	
	score_digit dut (.clk, .reset, .incr_in, .incr_out, .bcd);
	
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
		incr_in <= 0;
		@(posedge clk);
		reset <= 0;
		
		// tests nothing happening
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		// tests increases and incr_out
		for(integer i = 0; i < 13; i++) begin
			incr_in <= 1;
			@(posedge clk);
		end
		
		// tests nothing happening
		incr_in <= 0;
		for(integer i = 0; i < 13; i++) begin
			@(posedge clk);
		end
		$stop;
		
	end
	
endmodule