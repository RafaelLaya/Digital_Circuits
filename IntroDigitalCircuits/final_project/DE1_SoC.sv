// Flappy-Bird
// Reset is KEY[3]
// The player control is KEY[2]
// The score is shown on the HEX Display

// When using modelsim, do the following:
// 1. Uncomment `define TESTING 1 below
// 2. Uncomment `define TESTING 1 in counter_basic.sv
//`define TESTING 1

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 
	 /******************** Clock *********************/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 logic [19:0] score;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk), .reset(1'b0));
	 
	 `ifndef TESTING
	 assign SYSTEM_CLOCK = clk[14];
	 `endif
	 
	 `ifdef TESTING
		assign SYSTEM_CLOCK = CLOCK_50;
	 `endif
	 /************************************************/
	 
	 
	 /******************** LED Driver *********************/
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 assign RST = ~KEY[0];
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 /************************************************/
	 
	
	logic move;
	logic [15:0] new_pipe;
	logic freeze;
	
	// Creates pipes after counting a certain amount of MOVE pulses (changes with score)
	PipeFactory factory (.reset(RST), .clk(SYSTEM_CLOCK), .move(move), 
								.ledsFirstCol(new_pipe), .score);
								
	// Pipes are shifted every MOVE pulse
	SR_Basic_EN row00 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[00]),	.out(GrnPixels[00][15:0]));
	SR_Basic_EN row01 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[01]),	.out(GrnPixels[01][15:0]));
	SR_Basic_EN row02 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[02]),	.out(GrnPixels[02][15:0]));
	SR_Basic_EN row03 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[03]),	.out(GrnPixels[03][15:0]));
	SR_Basic_EN row04 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[04]),	.out(GrnPixels[04][15:0]));
	SR_Basic_EN row05 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[05]),	.out(GrnPixels[05][15:0]));
	SR_Basic_EN row06 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[06]),	.out(GrnPixels[06][15:0]));
	SR_Basic_EN row07 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[07]),	.out(GrnPixels[07][15:0]));
	SR_Basic_EN row08 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[08]),	.out(GrnPixels[08][15:0]));
	SR_Basic_EN row09 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[09]),	.out(GrnPixels[09][15:0]));
	SR_Basic_EN row10 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[10]),	.out(GrnPixels[10][15:0]));
	SR_Basic_EN row11 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[11]),	.out(GrnPixels[11][15:0]));
	SR_Basic_EN row12 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[12]),	.out(GrnPixels[12][15:0]));
	SR_Basic_EN row13 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[13]),	.out(GrnPixels[13][15:0]));
	SR_Basic_EN row14 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[14]),	.out(GrnPixels[14][15:0]));
	SR_Basic_EN row15 (.clk(SYSTEM_CLOCK), .reset(RST), .en(move), .in(new_pipe[15]),	.out(GrnPixels[15][15:0]));
	 
	logic KEY_F;
	logic KEY_FF;
	logic button_pressed;
	logic incr, decr;
	logic [3:0] bird_pos;
	logic flew;
	
	// User Input gets filtered through two DFFs and then feed onto the input controller and then the player manager
	// input controller checks for low->high patterns (holding the button counts only once)
	// player_manager managers the bird on the LED board
	D_FF filter0 (.q(KEY_F), .d(KEY[2]), .reset(RST), .clk(SYSTEM_CLOCK));
	D_FF filter1 (.q(KEY_FF), .d(KEY_F),  .reset(RST), .clk(SYSTEM_CLOCK));
	userInController userInCont (.in(~KEY_FF), .out(button_pressed), .reset(RST), .clk(SYSTEM_CLOCK));
	player_manager player (.clk(SYSTEM_CLOCK), .reset(RST), .move(move), .in(button_pressed), .incr(incr), .decr(decr), 
										.bot(RedPixels[15][15]), .top(RedPixels[0][15]), .lost(flew));
	
	// Keeps track of the bird position, which is then shown in the LED using a 4:16 decoder
	controlled_cntr bird_height_calculator (.reset(RST), .clk(SYSTEM_CLOCK), .out(bird_pos), .incr(incr), .decr(decr));
	decoder4 height_to_wire (.in(bird_pos), .out({		RedPixels[15][15],
																		RedPixels[14][15],
																		RedPixels[13][15],
																		RedPixels[12][15],
																		RedPixels[11][15],
																		RedPixels[10][15],
																		RedPixels[09][15],
																		RedPixels[08][15],
																		RedPixels[07][15],
																		RedPixels[06][15],
																		RedPixels[05][15],
																		RedPixels[04][15],
																		RedPixels[03][15],
																		RedPixels[02][15],
																		RedPixels[01][15],
																		RedPixels[00][15]}), 
															.en(~freeze));		
	logic incrScore;
	logic SW9_F, SW8_F, SW7_F;
	logic SW9_FF, SW8_FF, SW7_FF;
	
	// SW[9:7] will be used for cheat codes. SW[9:7] == 3'b101 enables god mode
	//													  SW[9:7] == 3'b010 enables slow-motion mode
	// in god mode, user can't lose (even if they had already lost, this will continue the game)
	// User input first gets filtered through two DFFs
	D_FF filter0SW9 (.q(SW9_F), .d(SW[9]),  .reset(RST), .clk(SYSTEM_CLOCK));
	D_FF filter0SW8 (.q(SW8_F), .d(SW[8]),  .reset(RST), .clk(SYSTEM_CLOCK));
	D_FF filter0SW7 (.q(SW7_F), .d(SW[7]),  .reset(RST), .clk(SYSTEM_CLOCK));
	
	D_FF filter1SW9 (.q(SW9_FF), .d(SW[9]),  .reset(RST), .clk(SYSTEM_CLOCK));
	D_FF filter1SW8 (.q(SW8_FF), .d(SW[8]),  .reset(RST), .clk(SYSTEM_CLOCK));
	D_FF filter1SW7 (.q(SW7_FF), .d(SW[7]),  .reset(RST), .clk(SYSTEM_CLOCK));
	
	// Then the score manager increases/decreases score as needed
	score_manager scoreBoard (.reset(RST), .clk(SYSTEM_CLOCK), .move(move), .flew(flew), .switches({SW9_FF, SW8_FF, SW7_FF}),  
										.incrScore(incrScore), .freeze(freeze), .red({	RedPixels[00][15],
																										RedPixels[01][15],
																										RedPixels[02][15],
																										RedPixels[03][15],
																										RedPixels[04][15],
																										RedPixels[05][15],
																										RedPixels[06][15],
																										RedPixels[07][15],
																										RedPixels[08][15],
																										RedPixels[09][15],
																										RedPixels[10][15],
																										RedPixels[11][15],
																										RedPixels[12][15],
																										RedPixels[13][15],
																										RedPixels[14][15],
																										RedPixels[15][15]}), 
																							.green({	GrnPixels[00][15], 
																										GrnPixels[01][15],
																										GrnPixels[02][15],
																										GrnPixels[03][15],
																										GrnPixels[04][15],
																										GrnPixels[05][15],
																										GrnPixels[06][15],
																										GrnPixels[07][15],
																										GrnPixels[08][15],
																										GrnPixels[09][15],
																										GrnPixels[10][15],
																										GrnPixels[11][15],
																										GrnPixels[12][15],
																										GrnPixels[13][15],
																										GrnPixels[14][15],
																										GrnPixels[15][15]}));
																										
		logic [3:0] bcd0, bcd1, bcd2, bcd3, bcd4, bcd5;
		logic incr_out0, incr_out1, incr_out2, incr_out3, incr_out4, incr_out5;
		
		// these are the digits for the score
		score_digit digit0 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incrScore), .incr_out(incr_out0), .bcd(bcd0));
		score_digit digit1 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incr_out0), .incr_out(incr_out1), .bcd(bcd1));
		score_digit digit2 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incr_out1), .incr_out(incr_out2), .bcd(bcd2));
		score_digit digit3 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incr_out2), .incr_out(incr_out3), .bcd(bcd3));
		score_digit digit4 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incr_out3), .incr_out(incr_out4), .bcd(bcd4));
		score_digit digit5 (.clk(SYSTEM_CLOCK), .reset(RST), .incr_in(incr_out4), .incr_out(incr_out5), .bcd(bcd5));
		
		// the basic counter is what produces the MOVE pulses that keeps the slow processes synchronized
		counter_basic main_cntr(.reset(RST), .clk(SYSTEM_CLOCK), .move(move), .freeze(freeze), .bcd0, .bcd1, .bcd2,
																															.bcd3, .bcd4, .bcd5,
																															.score, 
																												.switches({SW9_FF, SW8_FF, SW7_FF}));
		
		// score is shwon on the HEX displays
		seg7 seg7_0 (.bcd(bcd0), .leds(HEX0));
		seg7 seg7_1 (.bcd(bcd1), .leds(HEX1));
		seg7 seg7_2 (.bcd(bcd2), .leds(HEX2));
		seg7 seg7_3 (.bcd(bcd3), .leds(HEX3));
		seg7 seg7_4 (.bcd(bcd4), .leds(HEX4));
		seg7 seg7_5 (.bcd(bcd5), .leds(HEX5));
		
		
		// turn off red LEDs that will not be used
		always_comb begin
			for(integer row = 0; row < 16; row++) begin
				for(integer col = 0; col < 15; col++) begin
					RedPixels[row][col] = 1'b0;
				end
			end
		end
			 
endmodule

	 
module DE1_SoC_testbench();
    logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [3:0]  KEY;
	 logic [9:0]  SW;
	 logic [9:0]  LEDR;
    logic [35:0] GPIO_1;
    logic clk;
	 
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50(clk));
	 
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		KEY[0] <= 0;
		KEY[2] <= 1;
		SW[9:7] <= 0;
		@(posedge clk);
		KEY[0] <= 1;
		@(posedge clk);
		
		// tests going out of bounds: UP
		for(integer i = 0; i < 5 * 12; i++) begin
			KEY[2] <= ~KEY[2];
			@(posedge clk);
		end
		
		KEY[0] <= 0;
		@(posedge clk);
		KEY[0] <= 1;
		KEY[2] <= 1;
		@(posedge clk);
		
		// tests going out of bounds: DOWN
		for(integer i = 0; i < 5 * 12; i++) begin
			@(posedge clk);
		end
		
		KEY[0] <= 0;
		@(posedge clk);
		KEY[0] <= 1;
		KEY[2] <= 1;
		@(posedge clk);
		
		// tests crashing a pipe
		for(integer i = 0; i < 16; i++) begin
			KEY[2] <= 1;
			@(posedge clk);
			KEY[2] <= 0;
			@(posedge clk);
			
			for(integer i = 0; i < 8; i++) begin
				@(posedge clk);
			end
		end
		
		KEY[0] <= 0;
		@(posedge clk);
		KEY[0] <= 1;
		KEY[2] <= 1;
		@(posedge clk);
		
		// tests going through one hole
		for(integer i = 0; i < 16; i++) begin
			KEY[2] <= 1;
			@(posedge clk);
			KEY[2] <= 0;
			@(posedge clk);
			
			for(integer i = 0; i < 9; i++) begin
				@(posedge clk);
			end
		end
		
		
		$stop;
	end
endmodule