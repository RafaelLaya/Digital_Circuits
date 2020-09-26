/* Implements a simple monster for the game
 * Parameters:
 *		WIDTH					- WIDTH in pixels of the monster
 *		HEIGHT				- HEIGHT in pixels of the monster
 *		GROUND_NPC			- TRUE means the monster doesn't fly. FALSE means the monster flies.
 *		ID						- The ID the monster expects on the encoding_list to come out
 *		ENCODING_SIZE		- The size of the encoding list
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		encoding_list		- Element at index i is checked. If a high pulse is found, the monster
 *								  appears 
 *		move					- active-high pulses that synchronize the game
 *		collision			- active-high signal that represents the player has collided
 *		playing				- active-high signal that represents the game is being played
 *
 * Outputs:
 *   	monster_x			- Horizontal position of the monster on the screen
 *		monster_y			- Vertical position of the monster on the screen
 */
module basic_monster #(parameter WIDTH=32, HEIGHT=32, GROUND_NPC=0, ID=0, ENCODING_SIZE=16)
							  (clk, reset, monster_x, monster_y, encoding_list, move, collision, playing);
							  
	// synchronization variables
	input logic clk, reset;
	
	// external signals
	input logic [ENCODING_SIZE-1:0] encoding_list;
	input logic move, collision, playing;
	output logic [10:0] monster_x, monster_y; 
	
	// status signals
	logic out_of_screen;
	
	// control signals
	logic make_move, set_start_pos, remove;

	basic_monster_controller #(.ID(ID), .ENCODING_SIZE(ENCODING_SIZE)) controller (.*); 
	
	basic_monster_datapath #(.WIDTH(WIDTH), .GROUND_NPC(GROUND_NPC), .HEIGHT(HEIGHT)) datapath (.*);
	

endmodule // basic_monster

/* testbench for basic_monster */
module basic_monster_testbench();
	parameter WIDTH = 32;
	parameter HEIGHT = 32;
	parameter GROUND_NPC = 0;
	parameter ID = 6;
	parameter ENCODING_SIZE = 16;
	logic clk, reset;
	logic [ENCODING_SIZE-1:0] encoding_list;
	logic move, collision, playing;
	logic [10:0] monster_x, monster_y; 
	
	basic_monster #(.WIDTH(WIDTH), .HEIGHT(HEIGHT), .GROUND_NPC(GROUND_NPC), .ID(ID), .ENCODING_SIZE(ENCODING_SIZE)) dut (.*);
	
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
		encoding_list <= '0;
		move <= 0;
		collision <= 0;
		playing <= 0;
		@(posedge clk);
		reset <= 0;
		
		// idle for a bit
		repeat (5) @(posedge clk);
		
		// start playing
		playing <= 1;
		@(posedge clk);
		
		// wait for a bit 
		repeat (3) @(posedge clk);
		
		// put monster into screen
		encoding_list[ID] <= 1;
		move <= 1;
		@(posedge clk);
		encoding_list[ID] <= 0;
		move <= 0;
		
		// wait until next move
		repeat (3) @(posedge clk);
		
		// start making moves
		move <= 1;
		
		// wait until out of screen, and let the monster wait out of screen
		repeat (1000) @(posedge clk);
		
		// put the monster again in screen
		encoding_list[ID] <= 1;
		move <= 1;
		@(posedge clk);
		move <= 0;
		encoding_list[ID] <= 0;
		
		// move for a while
		move <= 1;
		repeat (200) @(posedge clk);
		
		// collide
		collision <= 1;
		repeat (5) @(posedge clk);
		collision <= 0;
		repeat (5) @(posedge clk);
		
		// go idle, and play again
		playing <= 0;
		@(posedge clk);
		playing <= 1;
		@(posedge clk);
		encoding_list[ID] <= 1;
		@(posedge clk);
		encoding_list[ID] <= 0;
		@(posedge clk);
		
		repeat (1000) @(posedge clk);
		
		$stop;
		
	end // initial
	
endmodule // basic_monster_testbench