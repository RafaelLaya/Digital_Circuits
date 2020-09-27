// Manages Flappy bird score
// green: The left-most column of the LED board (green pixels, active-high)
// red: The left-most column of the LED board (red pixels, active-high)
// flew: TRUE if the bird has gone out of bounds. Otherwise FALSE.
// incrScore: TRUE if the score should be increased, otherwise FALSE. 
//				  Score is increased if the bird just went through a pipe without crashing/losing
// freeze: TRUE if the game should be frozen (i.e.: Player lost)
// switches: if switches == 3'b101 then the freeze function is FALSE (this is a cheat code).
// everything synchronizes with the MOVE signal (an active-high pulse for 1 cycle)
module score_manager(reset, clk, move, green, red, flew, incrScore, freeze, switches);
	input logic [15:0] green, red;
	input logic reset, clk, move;
	input logic flew;
	input logic [2:0] switches;
	output logic incrScore;
	output logic freeze; 
	
	// collision/flew detection
	always_ff @(posedge clk) begin
		if(reset) freeze <= 0;
		else if(switches == 3'b101) freeze <= 0;
		else if(freeze) freeze <= 1;
		else if(flew) freeze <= 1;
		else if(move) begin
			for(int i = 0; i < 15; i++) begin
				if((green[i] == 1'b1 && red[i] == 1'b1)) freeze <= 1'b1;
			end
		end
		else freeze <= freeze;
	end
	
	// score increase logic
	logic shouldIncreaseNextMove;
	logic pipeExists;
	logic [3:0] redPosition;
	always_ff @(posedge clk) begin
		if(reset) shouldIncreaseNextMove <= 1'b0;
		else if (move) shouldIncreaseNextMove <= 1'b0;
		else if(shouldIncreaseNextMove) shouldIncreaseNextMove <= shouldIncreaseNextMove;
		else begin
			pipeExists = green[0];
			redPosition = 4'b0000;
			for(integer i = 0; i < 15; i++) begin
				if(red[i]) redPosition = 4'(i);
			end
			
			shouldIncreaseNextMove <= (red[redPosition] && ~green[redPosition] && pipeExists);
		end
	end
	
	// score increase when pipe moves
	always_ff @(posedge clk) begin
		if(reset) incrScore <= 1'b0;
		else if(shouldIncreaseNextMove && move && ~freeze) incrScore <= 1'b1;
		else incrScore <= 1'b0;
	end
	
endmodule

module score_manager_testbench();
	logic [15:0] green, red;
	logic flew;
	logic incrScore;
	logic freeze;
	logic clk, reset;
	logic move;
	
	score_manager dut (.green, .red, .flew, .incrScore, .freeze, .clk, .reset, .move);
	
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
		green <= 16'b0;
		red <= 16'b0;
		flew <= 1'b0;
		move <= 1'b0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		
		// tests nothing happening
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		// tests going out of bounds
		flew <= 1;
		@(posedge clk);
		move <= 1;
		@(posedge clk);
		move <= 0;
		flew <= 0;
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		@(posedge clk);
		
		// tests bird going through the hole
		green <= 	16'b1111111111000111;
		red <=	16'b0000000000010000;
		
		@(posedge clk);
		move <= 1;
		@(posedge clk);
		move <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		move <= 1;
		@(posedge clk);
		move <= 0;
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		
		// tests crash
		green <= 	16'b1111111111000111;
		red <=	16'b0000000000000001;
		move <= 1;
		@(posedge clk);
		move <= 0;
		@(posedge clk);
		@(posedge clk);
		
		
		$stop;
	end
	
endmodule
