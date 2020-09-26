/* Picks a monster to go out to the battlefield
 *
 *	Parameters:
 *		NUM_OF_MOSNTERS	- Number of total monsters implemented
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		move					- active-high pulses that synchronize the game
 *		next_level			- active-high pulses that signal a level transition
 *		playing				- active-high signal that represents the game being played
 *
 * Outputs:
 *   	encoding_list		- A list where each index represents a signal ID. A signal ID is set to high in a
 *								  pulse to indicate that monster with the given ID should go to the battlefield
 *
 *		VERY IMPORTANT: Set lsfr10's reset to be driven by 'reset' when simulating
 */
module monster_picker #(parameter NUM_OF_MONSTERS=1) (clk, reset, encoding_list, move, next_level, playing);
	parameter BIN_SIZE = (2 ** 10 - 1) / NUM_OF_MONSTERS;
	parameter CUTOFF = 379;
	
	input logic clk, reset, move, next_level, playing;
	output logic [NUM_OF_MONSTERS-1:0] encoding_list;
	
	logic [9:0] prediv;
	initial begin
		prediv <= 0;
	end // initial
	
	initial begin
		encoding_list <= 0;
	end // initial
	
	always_ff @(posedge clk) begin
		if(reset) prediv <= 0;
		else if(prediv > CUTOFF && move) prediv <= 0;
		else if(move) prediv <= prediv + 1;
	end // always_ff
	
	logic [9:0] max;
	always_ff @(posedge clk) begin
		if(reset || !playing) max <= 1;
		else if(max >= NUM_OF_MONSTERS) max <= 11'(NUM_OF_MONSTERS);
		else if(next_level) max <= max + 11'd1;
	end // always_ff
	
	logic [9:0] randomVar;
	lsfr10 randomizer (.Q(randomVar), .clk, .reset(1'b0));
	
	always_ff @(posedge clk) begin
		if(reset) encoding_list <= 0;
		else if(prediv > CUTOFF && move) encoding_list <= 1 << (randomVar % max);
		else encoding_list <= 0;
	end // always_ff
	
endmodule // monster_picker

/* testbench for monster_picker */
module monster_picker_testbench();
	parameter NUM_OF_MONSTERS = 3;
	logic clk, reset, move, next_level, playing;
	logic [NUM_OF_MONSTERS-1:0] encoding_list;
	
	monster_picker #(.NUM_OF_MONSTERS(NUM_OF_MONSTERS)) dut (.*);
	
	// simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// simulate inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		move <= 1'b0;
		next_level <= 1'b0;
		playing <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// no playing, no monsters
		repeat (600) @(posedge clk);
		
		// playing, but not moving, thus no monsters
		playing <= 1'b1;
		repeat (600) @(posedge clk);
		
		// level 1
		move <= 1'b1;
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		
		// go level 2
		next_level <= 1'b1;
		@(posedge clk);
		next_level <= 1'b0;
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		
		// go level 3
		next_level <= 1'b1;
		@(posedge clk);
		next_level <= 1'b0;
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		repeat (600) @(posedge clk);
		
		$stop;
	end // initial
	
endmodule // monster_picker_testbench 