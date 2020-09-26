/* Square wave generator at a given amplitude and frequency
 *
 * Parameters:
 *	   AMPLITUDE 	- Amplitude of the output square wave
 *		FREQ			- Frequency of the given wave. Only correct if the clock is 50MHz
 *
 * Inputs:
 *		clk			- Clock signal, connected to a 50MHz clock
 *		reset			- Active-high reset signal
 *
 * Outputs:
 *   wave			- Output of the square wave
 *  
 * Can be used to produce interesting sounds by combining various modules with 
 * different frequencies 
*/
module square_wave_sound_gen #(parameter AMPLITUDE=30000, FREQ=50000000) (clk, reset, wave);
	parameter PERIOD = 50000000 / FREQ;
	parameter HALF_PERIOD = PERIOD / 2;
	
	input logic clk, reset; 
	output logic signed [23:0] wave;
	
	logic [31:0] prediv; 
	
	always_ff @(posedge clk) begin
		if(reset) prediv <= '0;
		else if(prediv < PERIOD - 1) prediv <= prediv + 1; 
		else prediv <= 0;
	end // always_ff
	
	always_ff @(posedge clk) begin
		if(reset) wave <= '0;
		else if(prediv < HALF_PERIOD) wave <= 24'(AMPLITUDE);
		else wave <= 24'(-AMPLITUDE);
	end // always_ff

endmodule // square_wave_sound_gen

/* testbench for square_wave_sound_gen */
module square_wave_sound_gen_testbench();
	parameter AMPLITUDE=1000;
	parameter FREQ=5000000;
	logic clk, reset;
	logic signed [23:0] wave;
	
	square_wave_sound_gen #(.AMPLITUDE(AMPLITUDE), .FREQ(FREQ)) dut (.*);
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
	parameter SMALL_TIME = CLOCK_PERIOD / 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		for (integer i = 0; i < 100; i++) begin
			@(posedge clk);
			#(SMALL_TIME);
			assert((i % 10 < 5 && wave == AMPLITUDE) || (wave == -AMPLITUDE))
			else $display("Check waveform at %t", $time, i);
		end // for over i
		
		$stop; 
	end // initial
endmodule // square_wave_sound_gen_testbench