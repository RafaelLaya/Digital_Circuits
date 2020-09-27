/* Datapath for an animation where a line rotates around a fixed point
 *
 * Inputs:
 *   clk				- 1-bit clock signal
 *   reset			- 1-bit synchronous reset signal that clears the screen
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
 * Outputs:
 *   start		   		- 1-bit status signal that signals the start of drawing a new line
 *   color					- 1-bit signal that is TRUE when coloring white, FALSE when coloring black
 *   x0, y0, x1, y1		- 11-bits each for the coordinates (x0,y0) and (x1,y1) of the endpoints of the next
 *                        line to be drawn
 *
 *  Connected to animation_controller to produce an animated white line that rotates around a fixed point
 */
 
module animation_datapath(clk, reset, clr_P0, set_P1_top_right, set_color, clr_color, pick_new_coords, pulse_start, x0, x1, y0, y1, start, color, incr_vertically);
	// external signals
	input logic clk, reset;
	output logic [10:0] x0, x1, y1;
	output logic color;
	
	// control signals
	input logic clr_P0, set_P1_top_right, set_color, clr_color, pick_new_coords, pulse_start, incr_vertically;
	
	// status signals
	output logic start;
	output logic [10:0] y0;
	
	// start logic
	always_ff @(posedge clk) begin
		if(reset) start <= 1'b1;
		else if(pulse_start) start <= 1'b1;
		else start <= 1'b0;
	end // always_ff
	
	// color logic
	always_ff @(posedge clk) begin
		if(reset) color <= 1'b0;
		else if(set_color) color <= 1'b1;
		else if(clr_color) color <= 1'b0;
		else color <= color;
	end // always_ff
	
	// counter used for selecting the end-point of the next line
	logic [10:0] cntr;
	always_ff @(posedge clk) begin
		if(reset) cntr <= 0;
		else if(cntr <= 1114 && pick_new_coords) cntr <= 11'(cntr + 1);
		else if(pick_new_coords) cntr <= 0;
		else cntr <= cntr;
	end // always_ff
	
	// x0 logic
	always_ff @(posedge clk) begin
		if(reset) x0 <= 0;
		else if(clr_P0) x0 <= 0;
		else if(pick_new_coords && cntr <= 319) x0 <= cntr; 
		else if(pick_new_coords && cntr <= 558) x0 <= 319;  
		else if(pick_new_coords && cntr <= 877) x0 <= 11'(318 - (cntr - 559));
		else if(pick_new_coords && cntr <= 1115) x0 <= 0; 
		else x0 <= x0;
	end // always_ff
	
	// x1 logic
	always_ff @(posedge clk) begin
		if(reset) x1 <= 319;
		else if(set_P1_top_right) x1 <= 319;
		else if(pick_new_coords) x1 <= 159;
		else x1 <= x1;
	end // always_ff
	
	// y0 logic
	always_ff @(posedge clk) begin
		if(reset) y0 <= 0;
		else if(clr_P0) y0 <= 0;
		else if(incr_vertically && !start) y0 <= 11'(y0 + 1);
		else if(pick_new_coords && cntr <= 319) y0 <= 0; 
		else if(pick_new_coords && cntr <= 558) y0 <= 11'(cntr - 319);  
		else if(pick_new_coords && cntr <= 877) y0 <= 239;
		else if(pick_new_coords && cntr <= 1115) y0 <= 11'(239 - (cntr - 877)); 
		else y0 <= y0;
	end // always_ff
	
	// y1 logic
	always_ff @(posedge clk) begin
		if(reset) y1 <= 0;
		else if(set_P1_top_right) y1 <= 0;
		else if(incr_vertically && !start) y1 <= 11'(y1 + 1);
		else if(pick_new_coords) y1 <= 150;
		else y1 <= y1;
	end // always_ff
	
endmodule // animation_datapath

/* testbench for animation_datapath */
module animation_datapath_testbench();
	logic clk, reset;
	logic clr_P0, set_P1_top_right, set_color, clr_color, pick_new_coords, pulse_start, incr_vertically;
	logic [10:0] x0, x1, y1;
	logic start, color;
	logic [10:0] y0;
	
	animation_datapath dut (.*);
	
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
		clr_P0 <= 1'b0;
		set_P1_top_right <= 1'b0;
		set_color <= 1'b0;
		clr_color <= 1'b0;
		pick_new_coords <= 1'b0;
		pulse_start <= 1'b0;
		incr_vertically <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// test clr_P0
		clr_P0 <= 1'b1;
		@(posedge clk);
		clr_P0 <= 1'b0;
		
		// test set_P1_top_right
		set_P1_top_right <= 1'b1;
		@(posedge clk);
		set_P1_top_right <= 1'b0;
		
		// test set color and clr color
		set_color <= 1'b1;
		@(posedge clk);
		set_color <= 1'b0;
		clr_color <= 1'b1;
		@(posedge clk);
		clr_color <= 1'b0;
		
		// test pule_start
		pulse_start <= 1'b1;
		@(posedge clk);
		pulse_start <= 1'b0;
		@(posedge clk);
		
		// test incr_vertically
		incr_vertically <= 1'b1;
		@(posedge clk);
		incr_vertically <= 1'b0;
		
		// test pick new coords
		for(integer i = 0; i < 20; i++) begin
			pick_new_coords <= 1'b1;
			@(posedge clk);
		end
		
		$stop;
	end // initial
	
endmodule // animation_datapath_testbench