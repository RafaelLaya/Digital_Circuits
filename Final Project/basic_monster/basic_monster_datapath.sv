/* Implements the datapath of basic_monster
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		encoding_list		- Element at index i is checked. If a high pulse is found, the monster
 *								  appears 
 *		move					- active-high pulses that synchronize the game
 *		collision			- active-high signal that represents the player has collided
 *		playing				- active-high signal that represents the game is being played
 *		out_of_screen		- active-high status signal, tells controller the monster went out of screen on the left
 *
 * Outputs:
 *   	remove				- active-high control signal, tells datapath to remove the monster from the battlefield
 *		set_start_pos		- active-high control signal, tells datapath to initialize the start position of the monster on screen
 *		make_move			- active-high control signal, tells datapath to make a move (i.e.: move monster to the left by one step)
 */

module basic_monster_datapath #(parameter WIDTH=32, GROUND_NPC=0, HEIGHT=32) 
										(clk, reset, make_move, set_start_pos, remove, out_of_screen, monster_x, monster_y);
	
	// synchronization variables
	input logic clk, reset;
	
	// status signals
	output logic out_of_screen;
	
	// control signals
	input logic make_move, set_start_pos, remove;

	// external signals
	output logic [10:0] monster_x, monster_y;
	
	
	logic [9:0] random_y;
	lsfr10 monster_y_randomizer (.Q(random_y), .clk, .reset(1'b0));
	

	// this is the right-most x value of the monster sprite
	logic [10:0] right_limit;
	always_comb begin 
		right_limit = monster_x + 11'(WIDTH);
	end // always_comb
	
	// out_of_screen
	always_comb begin
		if(right_limit > 2000) out_of_screen = 1;
		else out_of_screen = 0;
	end // always_comb
	
	// monster_x
	always_ff @(posedge clk) begin
		if(reset) monster_x <= 11'(1000);
		else if(set_start_pos) monster_x <= 11'(640);
		else if(make_move) monster_x <= monster_x - 11'(1);
		else if(remove) monster_x <= 11'(1000);
		else monster_x <= monster_x;
	end // always_ff
	
	// monster_y
	always_ff @(posedge clk) begin
		if(reset) monster_y <= 1000;
		else if(set_start_pos) begin
			if(GROUND_NPC) monster_y <= 11'd240 - 11'(HEIGHT);
			else if(random_y < 682) monster_y <= 11'd240 - 11'(HEIGHT) - 11'(HEIGHT) + (HEIGHT < 11'd9 ? 11'(HEIGHT) : 11'd9);
			else monster_y <= 11'd240 - 11'(HEIGHT) - 11'(HEIGHT) - 11'(HEIGHT);
		end // if(set_start_pos)
		else if(remove) monster_y <= 1000;
		else monster_y <= monster_y;
	end // always_ff
	
endmodule // basic_monster_datapath

/* testbench for basic_monster_datapath */
module basic_monster_datapath_testbench();
	parameter WIDTH=32;
	parameter HEIGHT=32;
	parameter GROUND_NPC=0;
	
	// synchronization variables
	logic clk, reset;
	
	// status signals
	logic out_of_screen;
	
	// control signals
	logic make_move, set_start_pos, remove;

	// external signals
	logic [10:0] monster_x, monster_y;
	
	basic_monster_datapath #(.WIDTH(WIDTH), .HEIGHT(HEIGHT), .GROUND_NPC(GROUND_NPC)) dut (.*);
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1;
		make_move <= 0;
		set_start_pos <= 0;
		remove <= 0;
		@(posedge clk);
		reset <= 0;
		
		// remove
		remove <= 1;
		@(posedge clk);
		remove <= 0;
		
		// put the monster on screen
		repeat (5) @(posedge clk);
		set_start_pos <= 1;
		@(posedge clk);
		set_start_pos <= 0;
		
		// wait for a bit
		repeat (3) @(posedge clk);
		
		// move until out of screen
		make_move <= 1;
		@(posedge out_of_screen);
		remove <= 1;
		@(posedge clk);
		remove <= 0;
		
		// wait for a bit
		repeat (3) @(posedge clk);
		
		// put the monster on screen
		set_start_pos <= 1;
		@(posedge clk);
		set_start_pos <= 0;
		
		// wait until out of screen
		@(posedge out_of_screen);
		remove <= 1;
		@(posedge clk);
		remove <= 0;
		
		repeat (3) @(posedge clk);
		$stop;
		
	end // initial
	
endmodule // basic_monster_datapath