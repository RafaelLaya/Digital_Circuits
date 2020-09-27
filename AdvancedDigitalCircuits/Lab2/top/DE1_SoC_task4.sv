/* Memory RAM (2-port 32x4) module controlled by switches and visually represented
 * in seven segment displays. 
 * 
 * Inputs:
 *   SW[3:0]    - 4-bit data input signal. Written in memory when wren is TRUE
 *   SW[8:4]    - 5-bit write address
 *   SW[9]      - 1-bit write enable signal. Enables writing when TRUE
 *   KEY[0]     - 1-bit reset signal. Pressing the button resets the system. 
 *                The KEY[0] is normally-active, but it goes through an inverter
 *
 * Outputs:
 *   HEX5       - Most significant hexadecimal digit of the address selected to write
 *   HEX4       - Least significant hexadecimal digit of the address selected to write
 *   HEX3       - Most significant hexadecimal digit of the read address
 *   HEX2       - Least significant hexadecimal digit of the read address
 *   HEX1       - Data (hexadecimal unsigned representation) at address shown in 
 *                HEX3-HEX2
 *  
 * This top-level module provides the user the ability to watch the contents
 * of a memory module, as well as writing to the memory and seeing the changes. 
*/

// Uncomment for easier testing (testbench). Comment for uploading to the board
//`define TESTING

module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, rd_addr, dout);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	logic reset;
	logic clk;
	logic [3:0] din;
	output logic [3:0] dout;
	output logic [4:0] rd_addr;
	logic [4:0] wr_addr;
	logic wren;
	
	assign reset = ~KEY[0];
	assign clk = CLOCK_50;
	
	synchronizer #(.SIZE(4)) dinSync (.in(SW[3:0]), .out(din), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(5)) wr_addrSync (.in(SW[8:4]), .out(wr_addr), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(1)) wrenSync (.in(SW[9]), .out(wren), .clk(clk), .reset(reset));
	
	logic inc;
	
	`ifdef TESTING
	controlled_cntr #(.WIDTH(1), .N(2 - 1)) countOneSec (.clk(clk), .reset(reset), .inc(1'b1), .count(), .expired(inc));
	controlled_cntr #(.WIDTH(5), .N(31)) countAddr (.clk(clk), .reset(reset), .inc(inc), .count(rd_addr), .expired());
	`else
	controlled_cntr #(.WIDTH(26), .N(50000000 - 1)) countOneSec (.clk(clk), .reset(reset), .inc(1'b1), .count(), .expired(inc));
	controlled_cntr #(.WIDTH(5), .N(31)) countAddr (.clk(clk), .reset(reset), .inc(inc), .count(rd_addr), .expired());
	`endif
	
	ram32x4port2_wrapper memory (.clk(clk), .din(din), .rd_addr(rd_addr), .wr_addr(wr_addr), .wren(wren), .dout(dout));
	
	seg7 display_wr_addr_High (.bcd(wr_addr[4]), .leds(HEX5));
	seg7 display_wr_addr_Low (.bcd(wr_addr[3:0]), .leds(HEX4));
	
	seg7 display_rd_addr_High (.bcd(rd_addr[4]), .leds(HEX3));
	seg7 display_rd_addr_Low (.bcd(rd_addr[3:0]), .leds(HEX2));
	
	seg7 display_din (.bcd(din), .leds(HEX1));
	seg7 display_dout (.bcd(dout), .leds(HEX0));
	
endmodule // DE1_SoC

/* testbench for DE1_SoC */
// uncomment `define TESTING at the beggining of this file before simulation
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	logic CLOCK_50;
	logic clk;
	assign CLOCK_50 = clk;
	parameter CLOCK_PERIOD = 100;
	
	logic reset;
	logic [3:0] din;
	logic [3:0] dout;
	logic [4:0] rd_addr;
	logic [4:0] wr_addr;
	logic wren;
	
	DE1_SoC dut (.*);
	
	assign KEY[0] = ~reset;
	assign SW[3:0] = din;
	assign SW[8:4] = wr_addr;
	assign SW[9] = wren;
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		din <= 4'b0000;
		wr_addr <= 5'b00000; 
		wren <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// watch the system go through the memory
		for(integer i = 0; i < 32 * 2; i++) begin
			@(posedge clk);
		end // for
		
		// over-write something and watch it change
		wr_addr <= 5'0b0100;
		din <= 4'b0000;
		wren <= 1'b1;
		@(posedge clk);
		wren <= 1'b0;
		
		for(integer i = 0; i < 6 * 2; i++) begin
			@(posedge clk);
		end // for
		$stop;
		
	end // initial
	
endmodule // DE1_SoC_testbench
