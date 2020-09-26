/* Controller for an animation where a line rotates around a fixed point
 *
 * Inputs:
 *   clk				- 1-bit clock signal
 *   reset			- 1-bit synchronous reset signal that clears the screen
 *	  ready			- 1-bit active-high signal from line_drawer telling it is ready to draw the next line
 *   start		   - 1-bit signal that signals the start of drawing a new line
 *   y0				- 11-bits for the status of the value of the line on the screen that is being cleared after a rese
 *
 * Outputs:
 *   clr_P0					- 1-bit active-high signal that tells datapath to clear 
 *								  (x0,y0) so that it points to the left-top corner of the screen
 *   set_P1_top_right	- 1-bit active-high signal that tells datapath to set (x1,y1) to the
 *								  top-right of the screen
 *   set_color				- 1-bit active-high signal that tells datapath to set the drawing color to white
 *   clr_color				- 1-bit active-high signal that tells datapath to set the drawing color to black
 *   pick_new_coords		- 1-bit active-high signal that tells datapath to choose a new pair of endpoints
 *								  for the next line to draw during the animation
 *   pulse_start			- 1-bit active-high signal that tells datapath to pulse start to tell line_drawer
 *								  to draw a line
 *   incr_vertically    - 1-bit active-high signal that tells datapath to move (x0,y0) and (x1,y1) one unit 
 *                        vertically for purposes of clearing the screen
 *
 *  Connected to animation_datapath to produce an animated white line that rotates around a fixed point
 */
 
module animation_controller(clk, reset, clr_P0, set_P1_top_right, set_color, clr_color, ready, y0, pick_new_coords, pulse_start, incr_vertically, start);
	// external signals
	input logic clk, reset, ready;
	
	// control signals
	output logic clr_P0, set_P1_top_right, set_color, clr_color, pick_new_coords, pulse_start, incr_vertically;
	
	// status signals
	input logic [10:0] y0;
	input logic start;
	
	// all possible states of this module
	enum {INIT_SCREEN_CLEAR, START_NEXT_SCREEN_CLEAR, WAIT_SCREEN_CLEAR, UPDATE_SCREEN_CLEAR, CHOOSE_LINE, START_LINE_DRAW, 
			WAIT_LINE_DRAW} ps, ns;
	
	// state transition
	always_ff @(posedge clk) begin
		if(reset) ps <= INIT_SCREEN_CLEAR;
		else ps <= ns;
	end // always_ff
	
	// next-state logic
	always_comb begin
		case(ps) 
			INIT_SCREEN_CLEAR: begin
				ns = START_NEXT_SCREEN_CLEAR;
			end // INIT_SCREEN_CLEAR
			
			START_NEXT_SCREEN_CLEAR: begin
				ns = WAIT_SCREEN_CLEAR;
			end // START_NEXT_SCREEN_CLEAR
			
			WAIT_SCREEN_CLEAR: begin
				if(start) ns = WAIT_SCREEN_CLEAR;
				else if(!ready) ns = WAIT_SCREEN_CLEAR;
				else if(!(y0 >= 239)) ns = UPDATE_SCREEN_CLEAR;
				else ns = CHOOSE_LINE;
			end // WAIT_SCREEN_CLEAR
			
			UPDATE_SCREEN_CLEAR: begin
				ns = START_NEXT_SCREEN_CLEAR;
			end // UPDATE_SCREEN_CLEAR
			
			CHOOSE_LINE: begin
				ns = START_LINE_DRAW;
			end // CHOOSE_LINE
			
			START_LINE_DRAW: begin
				ns = WAIT_LINE_DRAW;
			end // START_LINE_DRAW
			
			WAIT_LINE_DRAW: begin
				if(start) ns = WAIT_LINE_DRAW;
				else if(!ready) ns = WAIT_LINE_DRAW;
				else ns = INIT_SCREEN_CLEAR;
			end // WAIT_LINE_DRAW
			
			default: begin
				ns = INIT_SCREEN_CLEAR;
			end // default
		endcase // case(ps)
	end // always_comb
	
	
	// clr_P0 logic
	always_comb begin
		if(ps == INIT_SCREEN_CLEAR) clr_P0 = 1'b1;
		else clr_P0 = 1'b0;
	end // always_comb
	
	// set_P1_top_right
	always_comb begin
		if(ps == INIT_SCREEN_CLEAR) set_P1_top_right = 1'b1;
		else set_P1_top_right = 1'b0;
	end // always_comb
	
	// clr_color
	always_comb begin
		if(ps == INIT_SCREEN_CLEAR) clr_color = 1'b1;
		else clr_color = 1'b0;
	end // always_comb
	
	
	// set_color
	always_comb begin
		if(ps == CHOOSE_LINE) set_color = 1'b1;
		else set_color = 1'b0;
	end // always_comb
	
	
	// pick_new_coords
	always_comb begin
		if(ps == CHOOSE_LINE) pick_new_coords = 1'b1;
		else pick_new_coords = 1'b0;
	end // always_comb
	
	// pulse_start
	always_comb begin
		if(ps == START_NEXT_SCREEN_CLEAR) pulse_start = 1'b1;
		else if(ps == START_LINE_DRAW) pulse_start = 1'b1;
		else pulse_start = 1'b0;
	end // always_comb
	
	// incr_vertically
	always_comb begin
		if(ps == UPDATE_SCREEN_CLEAR) incr_vertically = 1'b1;
		else incr_vertically = 1'b0;
	end // always_comb
	
endmodule // animation_controller

/* testbench for animation_controller */
module animation_controller_testbench();
	logic clk, reset, ready, start;
	logic clr_P0, set_P1_top_right, set_color, clr_color, pick_new_coords, pulse_start, incr_vertically;
	logic [10:0] y0;
	
	animation_controller dut (.*);
	
	// set-up clock
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
		reset <= 1'b1;
		ready <= 1'b0;
		y0 <= 0;
		start <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		
		start <= 1'b1;
		ready <= 1'b1;
		for(integer i = 0; i < 3; i++) begin
			@(posedge clk);
		end // for
		
		start <= 1'b0;
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end // for
		
		start <= 1'b1;
		for(integer i = 0; i < 3; i++) begin
			@(posedge clk);
		end // for
		
		start <= 1'b0;
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end // for
		
		y0 <= 239;
		start <= 1'b1;
		for(integer i = 0; i < 3; i++) begin
			@(posedge clk);
		end // for
		
		start <= 1'b0;
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end // for
		
		
		$stop;
		
	end // initial
endmodule // animation_controller_testbench