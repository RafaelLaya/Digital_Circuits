/* Line Drawer datapath that Implements Bressenham's Line
 * Drawing Algorithm
 *
 * Inputs:
 *   clk							- 1-bit clock signal
 *	  reset						- 1-bit active-high synchronous reset signal
 *	  x1, x0, y1, y0 			- 11-bit signals for position of points to draw in the format (x0,y0) and (x1,y1)
 *   calc_is_steep 			- 1-bit active-high signal that tells datapath to check if the line has slope greater than 1
 *   fix_steep       		- 1-bit active-high signal that tells datapath to internally compute the inverse of the given line,
 *                     		  but to remember to reverse the points before exposing them to the external world
 *   calc_reversed			- 1-bit active-high signal that tells datapath to check if (x0,y0) is the right-most point
 *   fix_reversed    		- 1-bit active-high signal that tells datapath to re-order the points internally
 *   init            		- 1-bit active-high signal that tells datapath to initialize all variables essential for the algorithm
 *   incr_x						- 1-bit active-high signal that tells datapath to increase x internally
 *   draw_inverted   		- 1-bit active-high signal that tells datapath to draw (y, x) to account for the internal swap of variables when
 *                     		  the line has slope greater than 1
 *   incr_decision_2dy		- 1-bit active-high signal that tells datapath to increase the decision variable by 2dy
 *   decr_decision_2dx     - 1-bit active-high signal that tells datapath to decrease the decision variable by 2dx
 *   incr_y					   - 1-bit active-high signal that tells datapath to add y_step to y
 *   calc_y_step				- 1-bit active-high signal that tells datapath to calculate y_step
 *   get_initials				- 1-bit active-high signal that tells datapath to remember the given values of x and y by the external world
 *   set_write					- 1-bit active-high signal that tells datapath to set write to TRUE, otherwise write is kept FALSE
 *   set_done					- 1-bit active-high signal that tells datapath to set done to TRUE, otherwise done is kept FALSE
 *
 * Outputs:
 *	  write						- 1-bit active-high write signal
 *	  x, y						- 11-bit signals for the position of the next point to draw on the screen
 *   is_steep					- 1-bit active-high signal that tells controller the line's slope is greater than 1
 *   is_reversed				- 1-bit active-high signal that tells controller (x0,y0) is the right-most point 
 *   done						- 1-bit active-high signal that tells the line has been drawn
 *   x1_internal				- 11-bits communicated to the controller for the right-most point of the x coordinate that is tracked internally
 *   x_internal				- 11-bits communicated to the controller for the  coordinate of the current point that is computed internally
 *   decision_var				- 14-bits for the decision variable that is communicated to the controller
 *   
 *  Connected to line_drawer_controller which commands this module to perform the appropriate actions
 */
 
module line_drawer_datapath(clk, reset, calc_is_steep, is_steep, fix_steep, calc_reversed, fix_reversed, init, x_internal, x1_internal, incr_x, draw_inverted,
									  decision_var, incr_decision_2dy, decr_decision_2dx, incr_y, x, y, is_reversed, x1, x0, y1, y0, calc_y_step, get_initials, set_write, 
									  set_done, write, done);


	// external signals
	input logic clk, reset;
	input logic [10:0] x1, x0, y1, y0;
	output logic write;
	output logic [10:0] x, y;
	
	// control signals
	input logic calc_is_steep, fix_steep, calc_reversed, fix_reversed, init, incr_x, draw_inverted, incr_decision_2dy, decr_decision_2dx, incr_y, calc_y_step, get_initials;
	input logic set_write, set_done;
	
	// status signals
	output logic is_steep, is_reversed, done;
	output logic [10:0] x1_internal, x_internal;
	output logic signed [13:0] decision_var;
	
	// local signals
	logic [10:0] x0_internal, y0_internal, y1_internal, y_internal;
	logic signed [31:0] y_step;
	logic signed [11:0] dx, dy;
	
	// write logic
	always_ff @(posedge clk) begin
		if(reset) write <= 1'b0;
		else if(set_write) write <= 1'b1;
		else write <= 1'b0;
	end // always_ff
	
	// done logic
	always_ff @(posedge clk) begin
		if(reset) done <= 1'b0;
		else if(set_done) done <= 1'b1;
		else done <= 1'b0;
	end // always_ff
	
	// is_steep logic
	always_ff @(posedge clk) begin
		if(reset) is_steep <= 1'b0;
		else if(calc_is_steep) is_steep <= (y1 > y0 ? y1 - y0 : y0 - y1) > (x1 > x0 ? x1 - x0 : x0 - x1);
		else is_steep <= is_steep;
	end // always_ff
	
	// x0_internal logic
	always_ff @(posedge clk) begin
		if(reset) x0_internal <= 0;
		else if(get_initials) x0_internal <= x0;
		else if(fix_steep) x0_internal <= y0_internal;
		else if(fix_reversed) x0_internal <= x1_internal;
		else x0_internal <= x0_internal;
	end // always_ff
	
	// x1_internal logic
	always_ff @(posedge clk) begin
		if(reset) x1_internal <= 0;
		else if(get_initials) x1_internal <= x1;
		else if(fix_steep) x1_internal <= y1_internal;
		else if(fix_reversed) x1_internal <= x0_internal;
		else x1_internal <= x1_internal;
	end // always_ff
	
	// y1_internal logic
	always_ff @(posedge clk) begin
		if(reset) y1_internal <= 0;
		else if(get_initials) y1_internal <= y1;
		else if(fix_steep) y1_internal <= x1_internal;
		else if(fix_reversed) y1_internal <= y0_internal;
		else y1_internal <= y1_internal;
	end
	
	// y0_internal logic
	always_ff @(posedge clk) begin
		if(reset) y0_internal <= 0;
		else if(get_initials) y0_internal <= y0;
		else if(fix_steep) y0_internal <= x0_internal;
		else if(fix_reversed) y0_internal <= y1_internal;
		else y0_internal <= y0_internal;
	end // always_ff
	
	// x_internal logic
	always_ff @(posedge clk) begin
		if(reset) x_internal <= 0;
		else if(init) x_internal <= x0_internal;
		else if(incr_x) x_internal <= x_internal + 11'(1);
		else x_internal <= x_internal;
	end // always_ff
	
	// y_internal logic
	always_ff @(posedge clk) begin
		if(reset) y_internal <= 0;
		else if(init) y_internal <= y0_internal;
		else if(incr_y) y_internal <= y_internal + 11'(y_step);
		else y_internal <= y_internal;
	end // always_ff
	
	// y_step logic
	always_ff @(posedge clk) begin
		if(reset) y_step <= 0;
		else if(calc_y_step) y_step <= (y0_internal < y1_internal ? 1 : -1);
		else y_step <= y_step;
	end // always_ff
	
	// x logic
	always_ff @(posedge clk) begin
		if(reset) x <= 0;
		else if(draw_inverted) x <= y_internal;
		else x <= x_internal;
	end // always_ff
	
	// y logic
	always_ff @(posedge clk) begin
		if(reset) y <= 0;
		else if(draw_inverted) y <= x_internal;
		else y <= y_internal;
	end // always_ff
	
	// dx logic
	always_ff @(posedge clk) begin
		if(reset) dx <= 0;
		else if(init) dx <= ($signed(x1_internal) - $signed(x0_internal));
		else dx <= dx;
	end // always_ff
	
	// dy logic
	always_ff @(posedge clk) begin
		if(reset) dy <= 0;
		else if(init) dy <= ((y1_internal > y0_internal) ? (y1_internal - y0_internal) : (y0_internal - y1_internal));
		else dy <= dy;
	end // always_ff
	
	// is_reversed logic
	always_ff @(posedge clk) begin
		if(reset) is_reversed <= 1'b0;
		else if(calc_reversed) is_reversed <= (x0_internal > x1_internal ? 1'b1 : 1'b0);
		else is_reversed <= is_reversed;
	end // always_ff
	
	// decision_var logic
	always_ff @(posedge clk) begin
		if(reset) decision_var <= 0;
		else if(init) decision_var <= 14'(2 * (y1_internal - y0_internal) - (x1_internal - x0_internal));
		else if(incr_decision_2dy && decr_decision_2dx) decision_var <= 14'(decision_var + 2 * dy - 2 * dx);
		else if(incr_decision_2dy) decision_var <= 14'(decision_var + 2 * dy);
		else decision_var <= decision_var;
	end // always_ff
	
endmodule // line_drawer_datapath

/* testbench for line_drawer_datapath */
module line_drawer_datapath_testbench();
	logic clk, reset;
	logic [10:0] x1, x0, y1, y0;
	logic write;
	logic [10:0] x, y;
	logic calc_is_steep, fix_steep, calc_reversed, fix_reversed, init, incr_x, draw_inverted, incr_decision_2dy, decr_decision_2dx, incr_y, calc_y_step, get_initials;
	logic set_write, set_done;
	logic is_steep, is_reversed, done;
	logic [10:0] x1_internal, x_internal;
	logic signed [13:0] decision_var;
	
	parameter CLOCK_PERIOD = 100;
	
	line_drawer_datapath dut (.*);
	
	// set-up clock
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
		x0 <= 0;
		y0 <= 0;
		x1 <= 100;
		y1 <= 100;
		
		set_write <= 1'b0;
		set_done <= 1'b0;
		calc_is_steep <= 1'b0;
		fix_steep <= 1'b0;
		calc_reversed <= 1'b0;
		fix_reversed <= 1'b0;
		init <= 1'b0;
		incr_x <= 1'b0;
		draw_inverted <= 1'b0;
		incr_decision_2dy <= 1'b0;
		decr_decision_2dx <= 1'b0;
		incr_y <= 1'b0;
		calc_y_step <= 1'b0;
		get_initials <= 1'b0;
		@(posedge clk); 
		reset <= 1'b0;
	
		// test get_initials
		get_initials <= 1'b1;
		@(posedge clk);
	
		// test calc_is_steep and fix_steep
		// non-steep
		calc_is_steep <= 1'b1;
		@(posedge clk);
		fix_steep <= 1'b1;
		calc_is_steep <= 1'b0;
		@(posedge clk);
		// steep
		fix_steep <= 1'b0;
		calc_is_steep <= 1'b1;
		y1 <= 300;
		@(posedge clk);
		calc_is_steep <= 1'b0;
		fix_steep <= 1'b1;
		@(posedge clk);
		fix_steep <= 1'b0;
		
		// test calc_reversed and fix_reversed
		// non-reversed
		calc_reversed <= 1'b1;
		fix_reversed <= 1'b0;
		@(posedge clk);
		calc_reversed <= 1'b0;
		fix_reversed <= 1'b1;
		@(posedge clk);
		// reversed
		x0 <= 200;
		x1 <= 100;
		@(posedge clk);
		calc_reversed <= 1'b1;
		fix_reversed <= 1'b0;
		@(posedge clk);
		calc_reversed <= 1'b0;
		fix_reversed <= 1'b1;
		@(posedge clk);
		
		// test incr_x
		incr_x <= 1'b1;
		@(posedge clk);
		incr_x <= 1'b0;
		
		// test draw_inverted
		draw_inverted <= 1'b1;
		@(posedge clk);
		draw_inverted <= 1'b0;
		
		// test calc_y_step and incr_y
		y0 <= 100;
		y1 <= 200;
		calc_y_step <= 1'b1;
		@(posedge clk);
		calc_y_step <= 1'b0;
		incr_y <= 1'b1;
		@(posedge clk);
		y1 <= 0;
		@(posedge clk);
		calc_y_step <= 1'b1;
		incr_y <= 1'b0;
		@(posedge clk);
		calc_y_step <= 1'b0;
		incr_y <= 1'b1;
		@(posedge clk);
		incr_y <= 1'b0;
		
		// test init
		x0 <= 100;
		y0 <= 100;
		x1 <= 200;
		y1 <= 300;
		get_initials <= 1'b1;
		@(posedge clk);
		get_initials <= 1'b0;
		calc_is_steep <= 1'b1;
		@(posedge clk);
		fix_steep <= 1'b1;
		calc_is_steep <= 1'b0;
		@(posedge clk);
		fix_steep <= 1'b0;
		calc_reversed <= 1'b1;
		@(posedge clk);
		calc_reversed <= 1'b0;
		fix_reversed <= 1'b1;
		@(posedge clk);
		fix_reversed <= 1'b0;
		@(posedge clk);
		init <= 1'b1;
		@(posedge clk);
		init <= 1'b0;
		@(posedge clk);
		
		// test incr_decision_2dy and decr_decision_2dx
		// also test set_done and set_write
		init <= 1'b1;
		set_write <= 1'b1;
		set_done <= 1'b1;
		@(posedge clk);
		init <= 1'b0;
		set_write <= 1'b0;
		set_done <= 1'b0;
		incr_decision_2dy <= 1'b1;
		@(posedge clk);
		decr_decision_2dx <= 1'b1;
		@(posedge clk);
		set_done <= 1'b1;
		x0 <= x1;
		y0 <= y1;
		incr_decision_2dy <= 1'b0;
		decr_decision_2dx <= 1'b0;
		@(posedge clk);
		set_done <= 1'b0;
		set_write <= 1'b0;
		@(posedge clk);
		
		$stop;
	end // initial
	
endmodule // line_drawer_datapath_testbench