/* Manages the game sound
 *
 * Inputs:
 *   	clk						- Clock signal
 *		reset						- active-high reset signal
 *		playing					- active-high sisgnal that represents the game is being played
 *		collision				- active-high signal that represents a collision
 *		next_level				- active-high signal pulse that represents a level transition
 *		jump						- active-high signal that represents a jump
 *		dyno_flying				- active-high signal that represents the main character is in the air
 *
 * Outputs:
 *   	writedata_left			- left-channel of audio
 *		writedata_right		- right-channel of audio
 *
 *		VERY IMPORTANT: See Sound_Simul.sv
 */
 
`include "Sound_Simul.sv"

module sound(clk, reset, playing, collision, jump, next_level, writedata_left, writedata_right, dyno_flying, soundOn);
	// external signals
	input logic clk, reset, soundOn;
	input logic playing, collision, jump, next_level, dyno_flying;
	output logic signed [23:0] writedata_left, writedata_right;
	
	// status signals
	logic cntr_done;
	
	// control signals
	logic play_3, play_300, play_200, play_100, play_400, reset_cntr;
	
	// internal signals
	logic [23:0] wave_out;
	
	sound_controller controller (.*);
	sound_datapath datapath (.*);
endmodule // sound

/* testbench for sound */
module sound_testbench();
	logic clk, reset, soundOn;
	logic playing, collision, jump, next_level, dyno_flying;
	logic signed [23:0] writedata_left, writedata_right;
	
	sound dut (.*);
	
	// simulate clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	`ifdef SOUND_SIMUL_0
	parameter SOUND_LENGTH = 9000000;
	`elsif SOUND_SIMUL_1
	parameter SOUND_LENGTH =	10;
	`elsif SOUND_SIMUL_2
	parameter SOUND_LENGTH = 9000000;
	`else 
	// No simulation
	parameter SOUND_LENGTH = 50000000;
	`endif 
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		soundOn <= 1'b0;
		playing <= 1'b0;
		collision <= 1'b0;
		jump <= 1'b0;
		next_level <= 1'b0;
		dyno_flying <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// no sound if not playing
		soundOn <= 1'b1;
		repeat (10) @(posedge clk);
		
		// no sound if sound off
		playing <= 1'b1;
		soundOn <= 1'b0;
		repeat (10) @(posedge clk);
		soundOn <= 1'b1;
		
		// footsteps
		repeat (SOUND_LENGTH * 2) @(posedge clk);
		
		// jumping makes no sound (no footsteps)
		jump <= 1'b1;
		@(posedge clk);
		jump <= 1'b0;
		dyno_flying <= 1'b1;
		repeat (SOUND_LENGTH) @(posedge clk);
		dyno_flying <= 1'b0;
		
		// next_level sound
		next_level <= 1'b1;
		@(posedge clk);
		next_level <= 1'b0;
		repeat (SOUND_LENGTH) @(posedge clk);
		
		// collision sound
		collision <= 1'b1;
		@(posedge clk);
		repeat (SOUND_LENGTH) @(posedge clk);
		collision <= 1'b0;
		playing <= 1'b0;
		@(posedge clk);
		playing <= 1'b1;
		
		repeat (SOUND_LENGTH / 10) @(posedge clk);
		
		$stop;
		
		
	end // initial
endmodule // sound_testbench