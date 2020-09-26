/* Implements the main character of the game
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		collision			- active-high signal indicates a collision occurred
 *		move					- active-high pulses that synchronize the game
 *		playing				- active-high signal that indicates the game is currently being played\
 *		down_pressed		- active-high signal that indicates the user wants dyno to duck
 *		spacebar_pressed	- active-high signal that indicates the user wants dyno to jump
 *
 * Outputs:
 *   	dyno_y				- vertical position of dyno
 *		dyno_x				- horizontal position of dyno
 *		dyno_up				- active-high signal indicates dyno is standing up
 *		dyno_flying			- active-high signal indicates dyno is on the air
 *		
 */
module dyno(reset, clk, collision, move, playing, down_pressed, spacebar_pressed, dyno_x, dyno_y, dyno_up, dyno_flying);
	// external signals
	input logic reset, clk, collision, move, playing, down_pressed, spacebar_pressed;
	output logic [10:0] dyno_x;
	output logic dyno_up, dyno_flying;
	
	// status signals
	output logic [10:0] dyno_y;
	
	// control signals
	logic clr_dyno_up, set_dyno_up, adv_up, adv_down, init, put_dyno_gnd;
	
	dynosaur_controller controller (.*);
	dynosaur_datapath datapath (.*);
		
endmodule // dyno

/* testbench for dynosaur */
module dyno_testbench();
	// external signals
	logic reset, clk, collision, move, playing, down_pressed, spacebar_pressed;
	logic [10:0] dyno_x, dyno_y;
	logic dyno_up, dyno_flying;
	
	dyno dut (.*);
	
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
		// put system to a known state
		reset <= 1;
		playing <= 0;
		
		collision <= 0;
		move <= 0;
		down_pressed <= 0;
		spacebar_pressed <= 0;
		
		@(posedge clk);
		reset <= 0;
		
		repeat (3) @(posedge clk);
		
		// start game
		playing <= 1;
		@(posedge clk);
		
		// duck down
		move <= 1;
		down_pressed <= 1;
		repeat (3) @(posedge clk);
		down_pressed <= 0;
		repeat (3) @(posedge clk);
		
		// jump
		spacebar_pressed <= 1;
		repeat (10) @(posedge clk);
		spacebar_pressed <= 0;
		repeat (10) @(posedge clk);
		
		repeat (200) @(posedge clk);
		
		$stop;
	end // initial
	
endmodule // dyno_testbench