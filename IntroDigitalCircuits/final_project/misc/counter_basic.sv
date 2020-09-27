// When testing modelsim, uncomment `define TESTING 1 below
//`define TESTING 1

// A basic counter that synchronizes slow processes (slower than the clock)
// reset: Reset the counter to zero
// move: TRUE pulse when things should get updated physically
// freeze: The counter gets frozen if freeze is TRUE. This freezes the game (i.e.: Player lost)
// score: score of the game, calculated off from a bcd number
// switches: if switches[2:0] == 3'b010 then the slow-motion cheat-code is activated
//				 Slow motion just makes the counter N=500, which is 2.5 times slower than the maximum
//				 speed, and 1.25 slower than the slowest speed
module counter_basic(reset, clk, move, freeze, bcd0, bcd1, bcd2, bcd3, bcd4, bcd5, score, switches);
	input logic reset, clk, freeze;
	input logic [3:0] bcd0, bcd1, bcd2, bcd3, bcd4, bcd5;
	input logic [2:0] switches;
	
	output logic [19:0] score;
	output logic move;
	
	logic [31:0] counter;
	logic [31:0] N;
	logic slow_motion_on;
	
	// score calculations
	always_comb begin
		score = 20'(bcd0) + 20'(bcd1 * 10) + 20'(bcd2 * 100) + 20'(bcd3 * 1000) + 20'(bcd4 * 10000) + 20'(bcd5 * 100000);
	end
	
	// slow-motion logic
	always_comb begin
		slow_motion_on = (switches == 3'b010);
	end
	
	`ifndef TESTING
	// counter value: Changes based on the score of the player (makes game go faster)
	always_comb begin
		if(!slow_motion_on) begin
			if(score < 5) 			N = 400;
			else if(score < 10) 	N = 380;
			else if(score < 20) 	N = 360;
			else if(score < 30) 	N = 340;
			else if(score < 35) 	N = 320;
			else if(score < 40) 	N = 300;
			else if(score < 45) 	N = 280;
			else if(score < 50) 	N = 260;
			else if(score < 55) 	N = 240;
			else if(score < 60) 	N = 220;
			else						N = 200;
		end 
		else begin
			N = 500;
		end
	end
	`endif
	
	// when testing on modelsim, use a small value of N to not run out of memory
	`ifdef TESTING
	always_comb begin
		N = 5;
	end
	`endif
	
	// counter logic
	always_ff @(posedge clk) begin
		if(reset) counter <= 32'b0;
		else if(freeze) counter <= 32'b0;
		else if(counter >= N) counter <= 32'b0;
		else counter <= (counter + 32'b1);
	end
	
	// update the game when counter reaches N
	always_comb begin
		move = (counter >= N);
	end
endmodule

module counter_basic_testbench();
	logic reset, clk;
	logic move, freeze;
	logic [3:0] bcd0, bcd1, bcd2, bcd3, bcd4, bcd5;
	logic [31:0] score;
	
	
	counter_basic dut (.reset, .clk, .move, .freeze, .score, .bcd0, .bcd1, .bcd2, .bcd3, .bcd4, .bcd5);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		freeze <= 0;
		bcd0 <= 4'b0000;
		bcd1 <= 4'b0000;
		bcd2 <= 4'b0000;
		bcd3 <= 4'b0000;
		bcd4 <= 4'b0000;
		bcd5 <= 4'b0000;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		
		// tests game going forward
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end

		// tests scores
		for(integer i = 0; i < 100; i++) begin
			if(i % 1 == 0) bcd0 <= bcd0 + 4'b0001;
			if(i % 2 == 0) bcd1 <= bcd1 + 4'b0001;
			if(i % 3 == 0) bcd2 <= bcd2 + 4'b0001;
			if(i % 4 == 0) bcd3 <= bcd3 + 4'b0001;
			if(i % 5 == 0) bcd4 <= bcd4 + 4'b0001;
			if(i % 6 == 0) bcd5 <= bcd5 + 4'b0001;
			@(posedge clk);
		end
		
		// tests game frozen
		freeze <= 1;
		for(integer i = 0; i < 100; i++) begin
			@(posedge clk);
		end
		
		$stop;
	end
endmodule