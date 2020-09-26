/* Manages the score for the game
 *
 * Inputs:
 *		clk						- Clock signal, connected to a 50MHz clock
 *		reset						- Active-high reset signal
 *		move						- active-high signal that synchronizes movements in the game
 *		collision				- active-high signal that represents game lost due to a collision
 *		playing					- active-high signal that represents the game being played
 *		dyno_up					- active-high signal that indicates the main character is standing up
 *
 * Outputs:
 *		score_sprite_list		- list of sprites for each digit in the score
 *		score_pos_list			- list of position of each digit (horizontal)
 *		score						- current score
 *  
*/
module score_manager (clk, reset, move, score_sprite_list, score_pos_list, collision, playing, score, dyno_up);
	input logic clk, reset, move, collision, playing, dyno_up;
	output logic [42:0] score_sprite_list [5:0][25:0];
	output logic [19:0] score;
	output logic [10:0] score_pos_list [9:0];
	
	// assign horizontal coordinates for each digit
	assign score_pos_list[0] = 11'(640 - 2   * 30);
	assign score_pos_list[1] = 11'(640 - 3   * 30);
	assign score_pos_list[2] = 11'(640 - 4   * 30);
	assign score_pos_list[3] = 11'(640 - 5   * 30);
	assign score_pos_list[4] = 11'(640 - 6   * 30);
	assign score_pos_list[5] = 11'(640 - 7   * 30);
	assign score_pos_list[6] = 11'(640 - 8   * 30);
	assign score_pos_list[7] = 11'(640 - 9   * 30);
	assign score_pos_list[8] = 11'(640 - 10  * 30);
	assign score_pos_list[9] = 11'(640 - 11  * 30);
	
	// set-up the sprite list
	logic [42:0] digit0[25:0];
	logic [42:0] digit1[25:0];
	logic [42:0] digit2[25:0];
	logic [42:0] digit3[25:0];
	logic [42:0] digit4[25:0];
	logic [42:0] digit5[25:0];
	logic [42:0] digit6[25:0];
	logic [42:0] digit7[25:0];
	logic [42:0] digit8[25:0];
	logic [42:0] digit9[25:0];
	logic [42:0] digit_sprite_list[9:0][25:0];
	assign digit_sprite_list[0] = digit0;
	assign digit_sprite_list[1] = digit1;
	assign digit_sprite_list[2] = digit2;
	assign digit_sprite_list[3] = digit3;
	assign digit_sprite_list[4] = digit4;
	assign digit_sprite_list[5] = digit5;
	assign digit_sprite_list[6] = digit6;
	assign digit_sprite_list[7] = digit7;
	assign digit_sprite_list[8] = digit8;
	assign digit_sprite_list[9] = digit9;
	
	// get digits from memory
	ROM_digits digits_sprite_mem (.digit0, .digit1, .digit2, .digit3, .digit4, .digit5, .digit6, .digit7, .digit8, .digit9);
	
	// score increases faster if main character is standing up
	logic [7:0] prediv, prediv_num;
	always_comb begin
		if(dyno_up) prediv_num = 44;
		else prediv_num = 250; 
	end // always_comb
	
	always_ff @(posedge clk) begin
		if(reset) prediv <= 0;
		else if(collision) prediv <= prediv;
		else if(prediv > prediv_num) prediv <= 0;
		else if (move) prediv <= prediv + 8'(1);
	end // always_ff
	
	// score logic
	always_ff @(posedge clk) begin
		if(reset || !playing) score <= 0;
		else if(score > 999998) score <= score;
		else if(prediv > prediv_num) score <= score + 20'(1);
		else score <= score;
	end // always_ff
	
	// choose digits from the sprites
	always_comb begin
		score_sprite_list[0] = digit_sprite_list[score % 10];
		score_sprite_list[1] = digit_sprite_list[score / 10 % 10];
		score_sprite_list[2] = digit_sprite_list[score / 100 % 10];
		score_sprite_list[3] = digit_sprite_list[score / 1000 % 10];
		score_sprite_list[4] = digit_sprite_list[score / 10000 % 10];
		score_sprite_list[5] = digit_sprite_list[score / 100000 % 10];
	end // always_comb
endmodule // score_manager

/* testbench for score_manager */
module score_manager_testbench();
	logic clk, reset, move, collision, playing, dyno_up;
	logic [42:0] score_sprite_list [5:0][25:0];
	logic [19:0] score;
	logic [10:0] score_pos_list [9:0];
	
	score_manager dut (.*);
	
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
		move <= 1'b0;
		collision <= 1'b0;
		playing <= 1'b0;
		dyno_up <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		
		// no points if not playing
		repeat (500) @(posedge clk);
		
		// get some points
		move <= 1'b1;
		playing <= 1'b1;
		repeat (500) begin
			move <= 1'b1;
			@(posedge clk);
			move <= 1'b0;
			@(posedge clk);
		end
		
		// move off gets no points
		move <= 1'b0;
		repeat (500) @(posedge clk);
		move <= 1'b1;
		
		// duck and get points
		dyno_up <= 1'b0;
		repeat (500) begin
			move <= 1'b1;
			@(posedge clk);
			move <= 1'b0;
			@(posedge clk);
		end
		
		// collision: points should freeze
		collision <= 1'b1;
		repeat (500) @(posedge clk);
		
		// re-playing should reset the score
		playing <= 1'b0;
		collision <= 1'b0;
		@(posedge clk);
		playing <= 1'b1;
		
		repeat (500) @(posedge clk);
		
		@(posedge clk);
		$stop;
	end // initial
	
endmodule // score_manager