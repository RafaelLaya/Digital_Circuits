/* Given two points on the screen this module draws a line between
 * those two points by coloring necessary pixels using bressenham's
 * line generation algorithm
 *
 * Inputs:
 *   clk    - 1-bit clock signal
 *   reset  - 1-bit active high reset signal
 *	  x0 		- 11-bits for the x coordinate of the first end point
 *   y0 		- 11-bits for the y coordinate of the first end point
 *   x1 		- 11-bits for the x coordinate of the second end point
 *   y1 		- 11-bits for the y coordinate of the second end point
 *   start  - 1-bit active high signal that tells the system when to start drawing 
 *            the next line
 *
 * Outputs:
 *   x 		- 11-bits for the x coordinate of the pixel to color
 *   y 		- 11-bits for the y coordinate of the pixel to color
 *
 */
module line_drawer(clk, reset, x0, y0, x1, y1, x, y, start, write, ready);
	input logic clk, reset, start;
	input logic [10:0]	x0, y0, x1, y1;
	output logic [10:0]	x, y;
	output logic write, ready;
	
	// control signals
	logic calc_is_steep, is_steep, fix_steep, calc_reversed, fix_reversed, init, get_initials, incr_y, is_reversed, calc_y_step;
	logic incr_decision_2dy, decr_decision_2dx, incr_x, draw_inverted, set_write, set_done;
	
	// status signals
	logic [10:0] x_internal, x1_internal;
	logic done;
	logic signed [13:0] decision_var;
	
	line_drawer_controller control (.*);
	line_drawer_datapath datapath (.*);
endmodule //line_drawer


/* testbench for line_drawer */
module line_drawer_testbench();
	logic clk, reset;
	logic [10:0]	x0, y0, x1, y1;
	logic [10:0]	x, y;
	logic start, write;
	logic done, ready;
	
	line_drawer dut (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		start <= 1'b1;
		x1 <= 60;
		x0 <= 50;
		y0 <= 40; 
		y1 <= 56;
		
		for(integer i = 0; i < 25; i++) begin
			@(posedge clk);
		end
		
		$stop;
	end

endmodule // line_drawer_testbench