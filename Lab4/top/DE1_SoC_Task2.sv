/* Top level module for a binary seacher for a pre-defined array in memory
 * 
 * Inputs:
 *		KEY[0]		- 1-bit reset signal. System resets when KEY[0] is pressed
 *		CLOCK_50		- 1-bit clock signal
 * 	SW[9]			- 1-bit active-high start signal
 *		SW[7:0]		- 8-bits of the data that will be searched for in memory
 *
 * Outputs:
 *		LEDR[9]		- TRUE if item is found
 *		HEX1-HEX0	- The location in memory where the input was found (if found)
 *
 * Used to find an element in my_array.mif
*/

module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	// unused HEX displays and LEDRs
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR[7:0] = '0;
	
	// use CLOCK_50 as the clock
	logic clk;
	assign clk = CLOCK_50;
	
	// reset when KEY[0] is pressed
	logic reset;
	assign reset = ~KEY[0];
	
	// declare internal signals
	logic done, found, start;
	logic [7:0] userData;
	logic [4:0] m;
	
	// synchronize external inputs
	synchronizer #(.SIZE(1)) startSynchronizer (.in(SW[9]), .out(start), .clk, .reset);
	synchronizer #(.SIZE(8)) userDataSynchronizer (.in(SW[7:0]), .out(userData), .clk, .reset);
	
	// feedback for the user
	assign LEDR[9] = found;
	assign LEDR[8] = done;
	
	// connect the binary searcher
	binary_searcher searcher (.clk, .reset, .done, .found, .start, .userData, .m, .ready());
	
	// lookup table for decimal to BCD conversion
	localparam logic [7:0] DEC_TO_BCD [31:0] = '{
				8'h31,
				8'h30,
				8'h29,
				8'h28,
				8'h27,
				8'h26,
				8'h25,
				8'h24,
				8'h23,
				8'h22,
				8'h21,
				8'h20,
				8'h19,
				8'h18,
				8'h17,
				8'h16,
				8'h15,
				8'h14,
				8'h13,
				8'h12,
				8'h11,
				8'h10,
				8'h09,
				8'h08,
				8'h07,
				8'h06,
				8'h05,
				8'h04,
				8'h03,
				8'h02,
				8'h01,
				8'h00
	};
	logic [6:0] ledsUnits, ledsTens;
	seg7 displayUnits (.bcd(DEC_TO_BCD[m][3:0]), .leds(ledsUnits));
	seg7 displayTens (.bcd(DEC_TO_BCD[m][7:4]), .leds(ledsTens));
	
	always_comb begin
		if(found) begin
			HEX1 = ledsTens;
			HEX0 = ledsUnits;
		end // if(found)
		else begin
			HEX0 = '1;
			HEX1 = '1;
		end // else
	end // always_comb
	
endmodule // DE1_SoC

/* testbench for DE1_SoC */
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	
	// aliases for easier testbench writing
	logic clk;
	assign CLOCK_50 = clk;
	
	logic reset;
	assign KEY[0] = ~reset;
	
	logic done;
	assign done = LEDR[8];
	
	logic start;
	assign SW[9] = start;
	
	logic [7:0] userData;
	logic [7:0] expectedIndex;
	assign SW[7:0] = userData;
	
	
	DE1_SoC dut (.*);
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// {a, b} where a is the target, and b is the index where it should be found
	// 255 means Not found within this testbench
	localparam logic [15:0] array[0:7] = {{8'd10, 8'd0}, 
													  {8'd65, 8'd31},
													  {8'd70, 8'd255},
													  {8'd20, 8'd255},
													  {8'd32, 8'd255}, 
													  {8'd58, 8'd26},
													  {8'd60, 8'd27}, 
													  {8'd52, 8'd21}};
	
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		userData <= 0;
		start <= 0;
		@(posedge clk);
		reset <= 1'b0;
		
		
		// go through the test cases
		for(integer i = 0; i < 8; i++) begin
			{userData, expectedIndex} <= array[i];
			start <= 1'b1;
			@(posedge clk);
			@(posedge done);
			start <= 1'b0;
			@(posedge clk);
		end // for
		$stop;
	end // initial
endmodule // DE1_SoC_testbench
