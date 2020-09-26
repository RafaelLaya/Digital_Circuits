/* Rotates sprite for a basic monster
 *
 * Parameters:
 *		WIDTH:			- Width in pixels of the sprite
 *	  	HEIGHT			- Height in pixels of the sprite
 *	  	NUM_SPRITES		- Number of sprites supplied
 *
 * Inputs:
 *   	reset				- active-high reset signal
 *	  	clk				- Clock signal
 *	  	sprites_list	- A list of supplied sprites
 *   	move				- Active-high signals an update
 *	  	collision 		- active-high collision signal (stops rotating sprites)
 *	  	anim				- active-high signal tells module to keep rotating if no collision has occurred
 *
 * Outputs:
 *   sprite				- The current sprite for this monster
 *
 *   Can be used with basic_monster to easily create a new type of monster
 */
 
module sprite_rotator #(parameter WIDTH=32, HEIGHT=32, NUM_SPRITES=2) (reset, clk, sprites_list, sprite, move, collision, anim);
	input logic reset, clk, move, collision, anim;
	input logic [HEIGHT-1:0][23:0] sprites_list [NUM_SPRITES-1:0][WIDTH-1:0];
	output logic [HEIGHT-1:0][23:0] sprite [WIDTH-1:0];
	
	// slow down through a predivisor
	logic [7:0] prediv;
	always_ff @(posedge clk) begin
		if(reset) prediv <= 0;
		else if(move && prediv > 10) prediv <= 0;
		else if(move) prediv <= prediv + 1;
	end // always_ff
	
	// decide when to switch
	logic switch;
	always_ff @(posedge clk) begin
		if(reset) switch <= 0;
		else if(move && prediv > 10) switch <= 1;
		else switch <= 0;
	end // always_ff
	
	// used to iterate over sprites
	logic [$clog2(NUM_SPRITES)-1:0] i;
	
	// do the switches 
	always_ff @(posedge clk) begin
		if(reset) i <= 0;
		else if(i >= NUM_SPRITES) i <= 0;
		else if(collision || !anim) i <= i;
		else if(switch) i <= (i + 1) % NUM_SPRITES;
	end // always_ff
	
	// assign the sprites
	always_ff @(posedge clk) begin
		if(reset) sprite <= sprites_list[0];
		else sprite <= sprites_list[i];
	end // always_ff
	
endmodule // sprite_rotator

/* testbench for sprite_rotator */
module sprite_rotator_testbench();
	parameter WIDTH = 1;
	parameter HEIGHT = 1;
	parameter NUM_SPRITES = 3;
	
	logic reset, clk, move, collision, anim;
	logic [HEIGHT-1:0][23:0] sprites_list [NUM_SPRITES-1:0][WIDTH-1:0];
	logic [HEIGHT-1:0][23:0] sprite [WIDTH-1:0];
	
	sprite_rotator #(.WIDTH(WIDTH), .HEIGHT(HEIGHT), .NUM_SPRITES(NUM_SPRITES)) dut (.*);
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// set up sprites
	initial begin
		sprites_list[0][0][0] = 24'hAB;
		sprites_list[1][0][0] = 24'hCD;
		sprites_list[2][0][0] = 24'hEF;
	end
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		anim <= 1'b1;
		move <= 1'b0;
		collision <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		
		// make a few hanges
		repeat (100) begin
			move <= ~move;
			@(posedge clk);
		end // repeat
		
		// collide!
		collision <= 1;
		repeat (100) begin
			move <= ~move;
			@(posedge clk);
		end // repeat
		
		// didn't collide, but now no animations
		collision <= 1'b0;
		anim <= 1'b0;
		repeat (100) begin
			move <= ~move;
			@(posedge clk);
		end // repeat
		
		$stop;
	end // initial

endmodule // sprite_rotator_testbench