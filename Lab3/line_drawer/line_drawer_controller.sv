/* Line Drawer Controller that Implements Bressenham's Line
 * Drawing Algorithm
 *
 * Inputs:
 *   clk          - 1-bit clock signal
 *   reset			- 1-bit active-high synchronous reset signal
 *   start			- 1-bit active-high start signal
 *   done			- 1-bit done signal. Asserted TRUE for 1 cycle when the line has been drawn
 *   is_steep     - 1-bit signal that is TRUE when the slope is greater than 1
 *   is_reversed  - 1-bit signal that is TRUE when (x0, y0) is the right-most point in the line
 *   decision_var - 14-bits decision variable from Bressenham's algorithm
 *   x_internal   - 11-bits for the current internal x coordinate (might be different from the 
 *                  coordinate drawn if the line has a slope greater than 1
 *   x1_internal  - 11-bits for the x coordinate of the right-most point in the line
 *
 * Outputs:
 *   ready						- 1-bit signal that is TRUE when the system is ready to draw another line upon a start signal
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
 *  Connected to line_drawer_datapath inside a line_drawer module for proper performance
 */
 
module line_drawer_controller(clk, reset, start, calc_is_steep, is_steep, fix_steep, calc_reversed, fix_reversed, init, x_internal, x1_internal, 
										incr_x, draw_inverted, decision_var, incr_decision_2dy, decr_decision_2dx, incr_y, done, is_reversed, calc_y_step, 
										get_initials, ready, set_write, set_done);
								
		// external signals		
		input logic clk, reset, start;
		output logic ready;
		
		// control signals
		output logic calc_is_steep, fix_steep, calc_reversed, fix_reversed, init, incr_x, draw_inverted, incr_decision_2dy, decr_decision_2dx, incr_y;
		output logic calc_y_step, get_initials, set_write, set_done;
		
		// status signals
		input logic is_steep, is_reversed;
		input logic signed [13:0] decision_var;
		input logic [10:0] x_internal, x1_internal;
		input logic done;
		
		// possible states
		enum {IDLE, CHECK_STEEP, FIXING_STEEP, CHECK_REVERSED, FIXING_REVERSED, INITIALIZING, COMPUTING} ps, ns;
		
		// state transition
		always_ff @(posedge clk) begin
			if(reset) ps <= IDLE;
			else ps <= ns;
		end // always_ff
		
		// next-state logic
		always_comb begin
			case(ps)
				IDLE: begin
					if(start) ns = CHECK_STEEP;
					else ns = IDLE;
				end // IDLE
				
				CHECK_STEEP: begin
					ns = FIXING_STEEP;
				end // CHECK_STEEP
				
				FIXING_STEEP: begin
					ns = CHECK_REVERSED;
				end // FIXING_STEEP
				
				CHECK_REVERSED: begin
					ns = FIXING_REVERSED;
				end // CHECK_REVERSED
				
				FIXING_REVERSED: begin
					ns = INITIALIZING;
				end // FIXING_REVERSED
				
				INITIALIZING: begin
					ns = COMPUTING;
				end // INITIALIZING
				
				COMPUTING: begin
					if(x_internal > x1_internal) ns = IDLE;
					else ns = COMPUTING;
				end // COMPUTING
				
				default: begin
					ns = IDLE;
				end // default
			endcase // case(ps)
		end // always_comb
		
		// ready logic
		always_comb begin
			if(reset) ready = 1'b1;
			else if(ps == IDLE) ready = 1'b1;
			else ready = 1'b0;
		end // always_comb
		
		// get initials
		always_comb begin
			if(reset) get_initials = 1'b1;
			else if(ps == IDLE) get_initials = 1'b1;
			else get_initials = 1'b0;
		end // always_comb
		
		// calc_is_steep logic
		always_comb begin
			if(ps == CHECK_STEEP) calc_is_steep = 1'b1;
			else calc_is_steep = 1'b0;
		end // always_comb
		
		// fix_steep logic
		always_comb begin
			if(ps == FIXING_STEEP && is_steep) fix_steep = 1'b1;
			else fix_steep = 1'b0;
		end // always_comb
		
		// calc_reversed logic
		always_comb begin
			if(ps == CHECK_REVERSED) calc_reversed = 1'b1;
			else calc_reversed = 1'b0;
		end // always_comb
		
		// fix_reversed logic
		always_comb begin
			if(ps == FIXING_REVERSED && is_reversed) fix_reversed = 1'b1;
			else fix_reversed = 1'b0;
		end // always_comb
		
		// init logic
		always_comb begin
			if(ps == INITIALIZING) init = 1'b1;
			else init = 1'b0;
		end // always_comb
		
		
		// incr_x logic
		always_comb begin
			if(ps == COMPUTING && !set_done) incr_x = 1'b1;
			else incr_x = 1'b0;
		end // always_comb
		
		// draw_inverted logic
		always_comb begin
			if(ps == COMPUTING && is_steep) draw_inverted = 1'b1;
			else draw_inverted = 1'b0;
		end // always_comb
		
		
		// incr_decision_2dy logic
		always_comb begin
			if(ps == COMPUTING && !set_done) incr_decision_2dy = 1'b1;
			else incr_decision_2dy = 1'b0;
		end // always_comb
		
		// decr_decision_2dx logic
		always_comb begin
			if(ps == COMPUTING && !set_done && !(decision_var < 0)) decr_decision_2dx = 1'b1;
			else decr_decision_2dx = 1'b0;
		end // always_comb
		 
		 // incr_y logic
		 always_comb begin
			if(ps == COMPUTING && !set_done && !(decision_var < 0)) incr_y = 1'b1;
			else incr_y = 1'b0;
		 end // always_comb
		
		 // set_write logic
		 always_comb begin
			if(ps == COMPUTING && !set_done) set_write = 1'b1;
			else set_write = 1'b0;
		 end // always_comb
		 
		 // set_done logic
		always_comb begin
			if(ps == COMPUTING && (x_internal > x1_internal)) set_done = 1'b1;
			else set_done = 1'b0;
		end // always_comb
		
		// calc_y_step logic
		always_comb begin
			if(ps == INITIALIZING) calc_y_step = 1'b1;
			else calc_y_step = 1'b0;
		end // always_comb
endmodule // line_drawer_controller

/* testbench for line_drawer_controller */
module line_drawer_controller_testbench();
	logic clk, reset, start;
	logic ready;
		
	logic calc_is_steep, fix_steep, calc_reversed, fix_reversed, init, incr_x, draw_inverted, incr_decision_2dy, decr_decision_2dx, incr_y;
	logic calc_y_step, get_initials, set_write, set_done;
		
	logic is_steep, is_reversed;
	logic signed [13:0] decision_var;
	logic [10:0] x_internal, x1_internal;
	logic done;
	
	line_drawer_controller dut (.*);
	
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
		done <= 1'b0;
		
		@(posedge clk);
		reset <= 1'b0;
		start <= 1'b1;
		
		// non steep and non reversed line
		is_steep <= 1'b0;
		is_reversed <= 1'b0;
		x_internal <= 100;
		x1_internal <= 200;
		
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
			decision_var <= i - 5;
		end
		
		
		@(posedge clk);
		x_internal <= x1_internal + 1;
		done <= 1'b1;
		@(posedge clk);
		done <= 1'b0;
		
		// non steep and reversed line
		is_steep <= 1'b0;
		is_reversed <= 1'b1;
		x_internal <= 250;
		x1_internal <= 200;
		
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
			decision_var <= 5 - i;
		end
		
		@(posedge clk);
		x_internal <= x1_internal + 1;
		done <= 1'b1;
		@(posedge clk);
		done <= 1'b0;
		
		// steep and non reversed line
		is_steep <= 1'b1;
		is_reversed <= 1'b0;
		x_internal <= 100;
		x1_internal <= 200;
		
		for(integer i = 0; i < 10; i++) begin
			@(posedge clk);
			decision_var <= i;
		end
		
		@(posedge clk);
		x_internal <= x1_internal + 1;
		done <= 1'b1;
		@(posedge clk);
		done <= 1'b0;
		

		// steep and reversed line
		is_steep <= 1'b1;
		is_reversed <= 1'b1;
		x_internal <= 100;
		x1_internal <= 200;
		
		for(integer i = 0; i < 13; i++) begin
			@(posedge clk);
			decision_var <= -i;
		end
		
		@(posedge clk);
		x_internal <= x1_internal + 1;
		done <= 1'b1;
		@(posedge clk);
		done <= 1'b0;
		for( integer i = 0; i < 5; i++) begin
			@(posedge clk);
		end
		
		$stop;
		
	end // initial
	
endmodule // line_drawer_controller_testbench
