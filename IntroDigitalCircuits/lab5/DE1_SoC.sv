module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;

	// Generate clk off of CLOCK_50, whichClock picks rate (See @clock_divider)
	logic [31:0] clk;
	parameter whichClock = 24;	
	
	// Set Hex Display Off since these won't be used. 
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
 
	// SW[0] and SW[1] go through two DFFs in series to ensure clean input
	logic SW0_Filtered, SW1_Filtered, in0, in1;
	D_FF SW0_FirstFilter		(.reset(1'b0), .clk(clk[whichClock]), .d(SW[0]), 			.q(SW0_Filtered));
	D_FF SW1_FirstFilter		(.reset(1'b0), .clk(clk[whichClock]), .d(SW[1]), 			.q(SW1_Filtered));
	D_FF SW0_SecondFilter 	(.reset(1'b0), .clk(clk[whichClock]), .d(SW0_Filtered), 	.q(in0));
	D_FF SW1_SecondFilter	(.reset(1'b0), .clk(clk[whichClock]), .d(SW1_Filtered), 	.q(in1));
 
	// Produce a low speed clock for the windMachine, based off the high speed 50MHz clock
	clock_divider cdiv(.clock(CLOCK_50), .reset(1'b0), .divided_clocks(clk));

	windMachine machine(.in1(in1), .in0(in0), .leds(LEDR[2:0]), .clk(clk[whichClock]), .reset(1'b0));
endmodule

// divided_clocks[i] = 25MHz / (2 to the power of (i+1))
module clock_divider (clock, divided_clocks, reset);
	input logic reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
endmodule 