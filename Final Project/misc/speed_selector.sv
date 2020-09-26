/* Regulates the speed of the game by alternating the 'move' signal and manages levels
 * In essence, regulates difficulty
 *
 * Inputs:
 *   	clk						- clock signal
 *		reset						- active-high reset signal
 *		score						- score of the player
 *		slow_down				- active-high signal represents cheat-code that slows down the game
 *
 * Outputs:
 *   	move						- active-high signal that updates the game
 *		next_level				- active-high pulse when a level-up occurs
 */
module speed_selector(clk, reset, score, move, next_level, slow_down);
	input logic [19:0] score;
	input logic clk, reset, slow_down;
	output logic move, next_level;
	
	// cntr is a predivider for the move signal
	logic [17:0] cntr;
	logic [17:0] prediv_val;
	always_ff @(posedge clk) begin
		if(reset) cntr <= 0;
		else if(cntr > prediv_val) cntr <= 0;
		else cntr <= cntr + 1;
	end // always_ff
	
	// game makes a move each time the predivider value is exceeded
	always_ff @(posedge clk) begin
		if(reset) move <= 0;
		else if(cntr > prediv_val) move <= 1;
		else move <= 0;
	end // always_ff
	
	// score dictates the speed of the game
	always_comb begin
		if      (score < 53 || slow_down)   prediv_val =   180287;
		else if (score < 103)   				prediv_val =   170413;  
		else if (score < 211)   				prediv_val =   160081;
		else if (score < 409)  					prediv_val =   151009;
		else if (score < 701)  					prediv_val =   140611;
		else if (score < 1013)  				prediv_val =   130027;
		else if (score < 1321)  				prediv_val =   120277;
		else if (score < 1873) 					prediv_val =   100103;
		else if (score < 2063) 					prediv_val =    90071;
		else if (score < 2897) 					prediv_val =    80111;
		else if (score < 4091) 					prediv_val =    70099;
		else                   					prediv_val =	 60449;
	end // always_comb

	// levelup
	logic next_level_buffer;
	always_comb begin
		if      (score ==   53) 	next_level_buffer = 1'b1;
		else if (score ==  103) 	next_level_buffer = 1'b1;
		else if (score ==  211) 	next_level_buffer = 1'b1;
		else if (score ==  409) 	next_level_buffer = 1'b1;
		else if (score ==  701) 	next_level_buffer = 1'b1;
		else if (score == 1013) 	next_level_buffer = 1'b1;
		else if (score == 1321) 	next_level_buffer = 1'b1;
		else if (score == 1873) 	next_level_buffer = 1'b1;
		else if (score == 2063) 	next_level_buffer = 1'b1;
		else if (score == 2897) 	next_level_buffer = 1'b1;
		else if (score == 4091) 	next_level_buffer = 1'b1;
		else                       next_level_buffer = 1'b0;
	end // always_ff
	
	rising_edge_checker levelup_filter (.in(next_level_buffer), .out(next_level), .reset, .clk);
	
endmodule // speed_selector

/* testbench for speed_selector */
module speed_selector_testbench();
	logic [19:0] score;
	logic clk, reset, slow_down;
	logic move;
	logic next_level;
	
	speed_selector dut (.*);
	
	integer t1, t2;
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
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
		score <= '0;
		slow_down <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// move a few times
		for (int i = 0; i < 3; i++) begin
			t1 = $time;
			@(posedge move);
			t2 = $time;
			assert((t2 - t1) / 100 == 180287+2) $display("Success: DeltaT = %d", (t2-t1) / 100);
			else $error("Error: %d", (t2-t1)/CLOCK_PERIOD);
		end // for over i
		
		// increase the score to move faster
		score <= 4000;
		for (int i = 0; i < 3; i++) begin
			t1 = $time;
			@(posedge move);
			t2 = $time;
			assert((t2 - t1) / 100 == 70099+2) $display("Success: DeltaT = %d", (t2-t1) / 100);
			else $error("Error: %d", (t2-t1)/CLOCK_PERIOD);
		end // for over i
		
		// level up
		score <= 4091;
		repeat (5) @(posedge clk);
		score <= 4100; 
		@(posedge clk);
		
		// cheat: slow down
		slow_down <= 1'b1;
		@(posedge move);
		for (int i = 0; i < 3; i++) begin
			t1 = $time;
			@(posedge move);
			t2 = $time;
			assert((t2 - t1) / 100 == 180287+2) $display("Success: DeltaT = %d", (t2-t1) / 100);
			else $error("Error: %d", (t2-t1)/CLOCK_PERIOD);
		end // for over i
		
		$stop;
	end // initial
	
endmodule // speed_selector_testbench