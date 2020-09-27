/* Memory module controlled by switches
 * 
 * Inputs:
 *   SW[3:0]    - 4-bit data-input signal, written when wren is TRUE into
 *                the address specified by SW[8:4]
 *   SW[9]      - 1-bit write enable signal (wren). TRUE for writing, otherwise false. 
 *   SW[8:4]    - 5-bit address signal.
 *   KEY[0]     - 1-bit enable signal for the memory 
 *
 * Outputs:
 *   HEX5       - Most significant hexadecimal digit of the current address selected by
 *                SW[8:4]
 *   HEX4       - Least significant hexadecimal digit of the current address selected by
 *                SW[8:4]
 *   HEX0       - Hexadecimal representation of the 4-bit contents of the memory in 
 *                the address selected by SW[8:4]
 *  
 * This top-level module provides the user the ability to read a memory 
 * by manually moving switches.
*/

// Uncomment for easier testing. Comment for uploading to the board
//`define TESTING

module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	logic reset;
	logic clk;
	
	// define clk and reset 
	assign clk = CLOCK_50;
	assign reset = ~KEY[3];
	
	// not used
	assign HEX3 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign LEDR[9:0] = 10'b00_0000_0000;
	
	logic [3:0] din;
	logic wren;
	logic [4:0] addr; 
	logic ramClk;
	
	`ifndef TESTING
	// synchronize external inputs to avoid meta-stablity
	synchronizer #(.SIZE(4)) dataInSynchronizer (.in(SW[3:0]), .out(din), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(1)) wrenSynchronizer (.in(SW[9]), .out(wren), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(5)) addrSynchronizer (.in(SW[8:4]), .out(addr), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(1)) ramClkSynchronizer (.in(~KEY[0]), .out(ramClk), .clk(clk), .reset(reset));
	`else
	assign din = SW[3:0];
	assign wren = SW[9];
	assign addr = SW[8:4];
	assign ramClk = clk;
	`endif
	
	// connect the RAM module
	logic [3:0] dout;
	ram32x4_wrapper memory (.address(addr), .din(din), .dout(dout), .wren(wren), .clk(ramClk));
	
	logic [3:0] addrHigh;
	logic [3:0] addrLow;
	assign addrHigh = 4'(addr[4]);
	assign addrLow = addr[3:0];
	
	// connect the displays
	seg7 addrHighDisplay (.bcd(addrHigh), .leds(HEX5));
	seg7 addrLowDisplay (.bcd(addrLow), .leds(HEX4));
	seg7 doutDisplay (.bcd(dout), .leds(HEX0));
	seg7 dinDisplay (.bcd(din), .leds(HEX2));
	
endmodule // DE1_SoC

/* testbench for DE1_SoC */
// uncomment `define TESTING at the beggining of this file before performing simulations
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic clk;
	parameter CLOCK_PERIOD = 100;
	
	logic [3:0] din;
	logic wren;
	logic [4:0] address;
	logic reset; 
	assign SW[3:0] = din;
	assign SW[9] = wren;
	assign SW[8:4] = address;
	assign KEY[3] = ~reset;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .KEY, .SW, .CLOCK_50(clk));
	
	// set-up clk 
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system
		reset <= 1'b1;
		address <= 5'b00000;
		din <= 4'b0000;
		wren <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		
		// writes 1010 to 00000
		wren <= 1'b1;
		address <= 5'b00000;
		din <= 4'b1010;
		@(posedge clk);
		
		// writes 1111 to 00010
		wren <= 1'b1;
		address <= 5'b00010;
		din <= 4'b1111;
		@(posedge clk);
		
		// writes 0101 to 00101
		wren <= 1'b1;
		address <= 5'b00101;
		din <= 4'b0101;
		@(posedge clk);
		@(posedge clk);
		
		// reads 1010 in 00000
		wren <= 1'b0;
		address <= 5'b00000;
		@(posedge clk);
		
		// reads 1111 in 00010
		address <= 5'b00010;
		@(posedge clk);
		
		// reads 0101 in 00101
		address <= 5'b00101;
		@(posedge clk);
		@(posedge clk);
		
		// overwrites the old 1111 in 00010 by 0000
		wren <= 1'b1;
		address <= 5'b00010;
		din <= 4'b0000;
		@(posedge clk);
		@(posedge clk);
		
		// checks the overwrite took effect
		wren <= 1'b0;
		address <= 5'b00010;
		@(posedge clk);
		@(posedge clk);
		
		$stop;
		
	end // initial
	
endmodule // DE1_SoC_testbench