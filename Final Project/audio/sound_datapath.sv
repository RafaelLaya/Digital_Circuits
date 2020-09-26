/* Datapath for the game-sound
 *
 * Inputs:
 *   	clk						- A 50MHz clock signal
 *		reset						- active-high reset signal
 *		play_X					- active-high signal that commands datapath to play a square wave of frequnecy X in Hz
 *		soundOn					- active-high signal that enables sound
 *
 * Outputs:
 *   	cntr_done				- active-high signal that indicates controller that the last wave sound is finished
 *		writedata_left			- left-channel sound output
 *		writedata_right		- right-channel sound output
 *
 *		HIGHLY IMPORTANT: See Sound_Simul.sv
 */
`include "Sound_Simul.sv"
 
module sound_datapath(reset, clk, play_3, play_100, play_200, play_300, play_400, cntr_done, writedata_left, writedata_right, soundOn, reset_cntr);
	// external signals
	input logic reset, clk;
	output logic signed [23:0] writedata_left, writedata_right;
	
	// control signal
	input logic play_3, play_100, play_200, play_300, play_400, soundOn, reset_cntr;
	
	// status signals
	output logic cntr_done;
	
	// internal signals
	logic signed [23:0] wave_out, wave_3, wave_100, wave_200, wave_300, wave_400;
	
	// different square waves
	square_wave_sound_gen #(.AMPLITUDE(300000), .FREQ(3)) wave_3hz (.clk, .reset, .wave(wave_3));
	square_wave_sound_gen #(.AMPLITUDE(300000), .FREQ(100)) wave_100hz (.clk, .reset, .wave(wave_100));
	square_wave_sound_gen #(.AMPLITUDE(300000), .FREQ(200)) wave_200hz (.clk, .reset, .wave(wave_200));
	square_wave_sound_gen #(.AMPLITUDE(300000), .FREQ(300)) wave_300hz (.clk, .reset, .wave(wave_300));
	square_wave_sound_gen #(.AMPLITUDE(300000), .FREQ(400)) wave_400hz (.clk, .reset, .wave(wave_400));
	
	// dictates how long each wave lasts
	// cntr is a predivider, and cntr_done is the status signal
	logic [31:0] cntr;
	
	`ifdef SOUND_SIMUL_0
	parameter PREDIV_VAL = 9000000;
	`elsif SOUND_SIMUL_1
	parameter PREDIV_VAL = 10;
	`elsif SOUND_SIMUL_2
	parameter PREDIV_VAL = 9000000 / 4;
	`else 
	// no simulation
	parameter PREDIV_VAL = 50000000;
	`endif 
	
	always_ff @(posedge clk) begin
		if(reset || reset_cntr) cntr <= 0;
		else if(cntr > PREDIV_VAL) cntr <= 0;
		else cntr <= cntr + 1;
	end // always_ff
	
	assign cntr_done = (cntr > PREDIV_VAL);
	
	// output wave
	always_ff @(posedge clk) begin
		if(reset) wave_out <= 0;
		else if(play_3) wave_out <= wave_3;
		else if(play_100) wave_out <= wave_100;
		else if(play_200) wave_out <= wave_200;
		else if(play_300) wave_out <= wave_300;
		else if(play_400) wave_out <= wave_400;
		else wave_out <= 0;
	end // always_ff
	
	// enable or disable the output
	assign writedata_left = soundOn ? wave_out : '0;
	assign writedata_right = soundOn ? wave_out : '0;
endmodule // sound_datapath

/* testbench for sound_datapath */
module sound_datapath_testbench();
	// external signals
	logic reset, clk;
	logic signed [23:0] writedata_left, writedata_right;
	
	// control signals
	logic play_3, play_100, play_200, play_300, play_400, soundOn, reset_cntr;
	
	// status signals
	logic cntr_done;
	
	sound_datapath dut (.*);
	
	// provide clock
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
		play_3 <= 1'b0;
		play_100 <= 1'b0;
		play_200 <= 1'b0;
		play_300 <= 1'b0;
		play_400 <= 1'b0;
		soundOn <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		reset_cntr <= 1'b0;
		
		// no sound
		soundOn <= 1'b0;
		repeat (5) @(posedge clk);
		soundOn <= 1'b1;
		
		// play_3
		play_3 <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset_cntr <= 1'b0;
		@(posedge cntr_done);
		play_3 <= 1'b0;
		@(posedge clk);
		
		// play_100
		play_100 <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset_cntr <= 1'b0;
		@(posedge cntr_done);
		play_100 <= 1'b0;
		@(posedge clk);
		
		// play_200
		play_200 <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset_cntr <= 1'b0;
		@(posedge cntr_done);
		play_200 <= 1'b0;
		@(posedge clk);
		
		// play_300
		play_300 <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset_cntr <= 1'b0;
		@(posedge cntr_done);
		play_300 <= 1'b0;
		@(posedge clk);
		
		// play_400
		play_400 <= 1'b1;
		reset_cntr <= 1'b1;
		@(posedge clk);
		reset_cntr <= 1'b0;
		@(posedge cntr_done);
		play_400 <= 1'b0;
		@(posedge clk);
		
		$stop;
	end // initial
	
endmodule // sound_datapath_testbench