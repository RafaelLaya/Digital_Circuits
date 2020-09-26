/* Implements the datapath of basic_monster
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		game_start			- active-high pulse that indicates the game should start. Connect to signal
 *								  of same name in menu
 *		collision			- active-high signal indicates a collision has occurred
 *		valid					- active-high signal indicates makeBreak and outCode are valid. Connect to
 *								  signal of same name in keyboard_press_driver
 *		makeBreak			- active-high signal indicates outCode is a make-code. Connect to signal of
 *								  same name in keyboard_press_driver
 *		outCode				- make or breakcode. Connect to signal of same name in keyboard_press_driver
 *
 * Outputs:
 *		playing				- active-high signal. Indicates a game is being played. Otherwise the menu should be displayed
 *  
 */
 
module main_control(clk, reset, game_start, collision, playing, valid, makeBreak, outCode);
	input logic clk, reset;
	input logic game_start, collision;
	input logic valid, makeBreak;
	input logic [7:0] outCode;
	output logic playing;
	
	// filter key 'r' and key 'm'
	logic key_r, key_m;
	keyboard_input_filter #(.MAKE(8'h2D), .BREAK(8'h2D)) r_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(key_r));
	keyboard_input_filter #(.MAKE(8'h3A), .BREAK(8'h3A)) m_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(key_m));

	// possible states
	enum {MENU, IN_GAME, LOST, WILL_REPLAY} ps, ns;
	
	// start on menu
	initial begin
		ps <= MENU;
	end // initial
	
	// state transitions
	always_ff @(posedge clk) begin
		if(reset) ps <= MENU;
		else ps <= ns;
	end // always_ff
	
	// next-state logic
	always_comb begin
		case(ps)
			MENU: begin
				if(game_start) ns = IN_GAME;
				else ns = MENU;
			end // MENU
			
			IN_GAME: begin
				if(collision) ns = LOST;
				else ns = IN_GAME;
			end // IN_GAME
			
			LOST: begin
				if(key_r) ns = WILL_REPLAY;
				else if(key_m) ns = MENU;
				else ns = LOST;
			end // LOST
			
			WILL_REPLAY: begin
				ns = IN_GAME;
			end // WILL_REPLAY
			
			default: begin
				ns = MENU;
			end // default
		
		endcase // case(ps)
	end // always_comb
	
	assign playing = (ps == IN_GAME || ps == LOST);
	
endmodule // main_control

/* testbench for main_control */
module main_control_testbench();
	logic clk, reset;
	logic game_start, collision;
	logic valid, makeBreak;
	logic [7:0] outCode;
	logic playing;
	
	main_control dut (.*);
	
	// simulate clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		game_start <= 1'b0;
		collision <= 1'b0;
		valid <= 1'b0;
		makeBreak <= 1'b0;
		outCode <= '0;
		@(posedge clk);
		reset <= 1'b0;
		
		// hang out on the menu
		repeat (5) @(posedge clk);
		
		// start game
		game_start <= 1'b1;
		@(posedge clk);
		game_start <= 1'b0;
		
		// play
		repeat (5) @(posedge clk);
		
		// lose
		collision <= 1'b1;
		repeat (5) @(posedge clk);
		
		// re-play
		makeBreak <= 1'b1;
		valid <= 1'b1;
		collision <= 1'b0;
		outCode <= 8'h2D;
		@(posedge clk);
		makeBreak <= 1'b0;
		outCode <= 8'h2D;
		@(posedge clk);
		valid <= 1'b0;
		
		// play
		repeat (5) @(posedge clk);
		
		// lose
		collision <= 1'b1;
		@(posedge clk);
		
		// go to menu
		valid <= 1'b1;
		makeBreak <= 1'b1;
		outCode <= 8'h3A;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		valid <= 1'b0;
		
		repeat (5) @(posedge clk);
		
		$stop;
		
	end // initial
endmodule // main_control_testbench