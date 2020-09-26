/* Implements a controller for a simple monster
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
module basic_monster_controller #(parameter ID=0, parameter ENCODING_SIZE=16) (clk, reset, encoding_list, move, collision, playing, remove, set_start_pos, make_move,
																										  out_of_screen);
	// synchronization variables
	input logic clk, reset;
	
	// external signals
	input logic [ENCODING_SIZE-1:0] encoding_list;
	input logic move, collision, playing;
	
	// control signals
	output logic remove, set_start_pos, make_move;
	
	// status signals
	input logic out_of_screen;
	
	// possible states
	enum {IDLE, WAITING, MOVING, FROZEN} ps, ns;
	
	// state transitions
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	// next-state logic
	always_comb begin
		case(ps)
			IDLE: begin
				if(playing) ns = WAITING;
				else ns = IDLE;
			end // IDLE
			
			WAITING: begin
				if(!playing) ns = IDLE;
				else if(encoding_list[ID]) ns = MOVING;
				else ns = WAITING;
			end // WAITING
			
			MOVING: begin
				if(!playing) ns = IDLE;
				else if(collision) ns = FROZEN;
				else if(out_of_screen) ns = WAITING;
				else ns = MOVING;
			end // MOVING
			
			FROZEN: begin
				if(playing) ns = FROZEN;
				else ns = IDLE;
			end // FROZEN
		
		endcase // case(ps)
	end // always_comb
	
	// remove
	always_comb begin
		if(ps == IDLE && playing) remove = 1;
		else if(!playing) remove = 1;
		else if(ps == MOVING && !collision && out_of_screen) remove = 1;
		else remove = 0;
	end // remove
	
	// set_start_pos
	always_comb begin
		if(ps == WAITING && encoding_list[ID]) set_start_pos = 1;
		else set_start_pos = 0;
	end // set_start_pos
	
	// make_move
	always_comb begin
		if(ps == MOVING && !collision && !out_of_screen && move) make_move = 1;
		else make_move = 0;
	end // make_move
	
endmodule // basic_monster_controller

/* testbench for basic_monster_controller */
module basic_monster_controller_testbench();
	// synchronization variables
	logic clk, reset;
	
	// external signals
	parameter ID=6;
	parameter ENCODING_SIZE = 10;
	logic [ENCODING_SIZE-1:0] encoding_list;
	logic move, collision, playing;

	// control signals
	logic remove, set_start_pos, make_move;
	
	// status signals
	logic out_of_screen;
	
	basic_monster_controller #(.ID(ID), .ENCODING_SIZE(ENCODING_SIZE)) dut (.*);
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		// put system into a known state
		reset <= 1;
		encoding_list <= '0;
		out_of_screen <= 0;
		move <= 0;
		collision <= 0;
		playing <= 0;
		@(posedge clk);
		reset <= 0;
		
		// idle for a bit
		repeat (3) @(posedge clk);
		
		// start the game and wait for a bit
		playing <= 1;
		repeat (3) @(posedge clk);
		
		// put this monster into screen
		move <= 1;
		encoding_list[ID] <= 1;
		@(posedge clk);
		encoding_list[ID] <= 0;
		move <= 0;
		
		// don't make a move
		@(posedge clk);
		
		// make a few move
		move <= 1;
		repeat (3) @(posedge clk);
		move <= 0;
		
		// get out of screen
		out_of_screen <= 1;
		@(posedge clk);
		out_of_screen <= 0;
		
		// put this monster into screen
		encoding_list[ID] <= 1;
		move <= 1;
		@(posedge clk);
		encoding_list[ID] <= 0;
		move <= 0;
		
		// make a few moves
		move <= 1;
		repeat (3) @(posedge clk);
		
		// collide
		collision <= 1;
		repeat (3) @(posedge clk);
		
		// go IDLE
		playing <= 0;
		repeat (2) @(posedge clk);
		$stop;
	end // initial
endmodule // basic_monster_controller_testbench