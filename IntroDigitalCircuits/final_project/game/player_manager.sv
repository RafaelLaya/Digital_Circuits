// manages the bird movements in flappy-bird
// in: TRUE if the player has made a movement, otherwise FALSE
// decr: TRUE if player made a movement, otherwise FALSE
// incr: TRUE if player did not make a movement, otherwise FALSE
// top: TRUE if the user is currently at the top-most position, otherwise FALSE
// bot: TRUE if the user is currently at the bottom-most position, otherwise FALSE
// lost: TRUE if the user flew out of bounds. i.e.: it is at the top and made a movement
//			or did not make a movement and was at the bottom
// move: movements, lost, incr, decr are recorded, but only effective once MOVE is found to be TRUE for a clock cycle
module player_manager(clk, reset, move, in, incr, decr, bot, top, lost);
	input logic clk, reset, move, in;
	output logic incr, decr;
	output logic lost;
	input logic bot, top;
	
	// need to remember if it has seen a movement before MOVE goes TRUE
	logic seenIn;
	
	// incr/decr/lost logic that gets synchronized with the MOVE signal
	always_ff @(posedge clk) begin
		if(reset) begin 
			incr <= 0;
			decr <= 0;
			lost <= 0;
		end
		else if(move && seenIn) begin
			if(top) begin
				lost <= 1;
				incr <= 0;
				decr <= 0;
			end 
			else begin
				incr <= 0;
				decr <= 1;
			end
		end
		else if(move && ~seenIn) begin
			if(bot) begin
				lost <= 1;
				incr <= 0;
				decr <= 0;
			end
			else begin
			incr <= 1;
			decr <= 0;
			end
		end
		else if(~move && seenIn) begin
			incr <= 0;
			decr <= 0;
			lost <= 0;
		end
		else if(~move && ~seenIn) begin
			incr <= 0;
			decr <= 0;
			lost <= 0;
		end
	end
	
	// state logic
	always_ff @(posedge clk) begin
		if(reset) seenIn <= 0;
		else if(move) seenIn <= 0;
		else if(in) seenIn <= 1;
		else seenIn <= seenIn;
	end
	
endmodule

module player_manager_testbench();
	logic clk, reset, move, in, incr, decr, top, bot;
	
	player_manager dut(.clk, .reset, .move, .in, .incr, .decr, .top, .bot);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		top <= 0;
		bot <= 0;
		reset <= 1;
		in <= 0;
		move <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		
		// tests when nothing is going on
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		// tests that movements get recorded but not effective unless MOVE is TRUE
		in <= 1;
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		move <= 1;
		@(posedge clk);
		move <= 0;
		@(posedge clk);
		
		
		// tests again another movement
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		in <= 1;
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		move <= 1;
		@(posedge clk);
		move <= 0;
		in <= 0;
		@(posedge clk);
		
		// tests when a player movement is not made
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		move <= 1;
		@(posedge clk);
		move <= 0;
		@(posedge clk);
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		
		// tests flying out of bounds
		top <= 1;
		@(posedge clk);
		in <= 1;
		@(posedge clk);
		move <= 1;
		@(posedge clk);
		top <= 0;
		in <= 0;
		move <= 0;
		@(posedge clk);
		bot <= 1;
		@(posedge clk);
		move <= 1;
		@(posedge clk);
		move <= 0;
		bot <= 0;
		@(posedge clk);
		@(posedge clk);
		

		$stop;
	end
	
endmodule