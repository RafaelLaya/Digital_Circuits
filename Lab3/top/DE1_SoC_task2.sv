/* Top level module of the FPGA that takes the onboard resources 
 * as input and outputs the lines drawn from the VGA port.
 *
 * Inputs:
 *   KEY 			- On board keys of the FPGA
 *   SW 			   - On board switches of the FPGA. SW[0] is used as an active-high
 *                  synchronous reset signal. 
 *   CLOCK_50 		- On board 50 MHz clock of the FPGA
 *
 * Outputs:
 *   HEX 			- On board 7 segment displays of the FPGA
 *   LEDR 			- On board LEDs of the FPGA
 *   VGA_R 			- Red data of the VGA connection
 *   VGA_G 			- Green data of the VGA connection
 *   VGA_B 			- Blue data of the VGA connection
 *   VGA_BLANK_N 	- Blanking interval of the VGA connection
 *   VGA_CLK 		- VGA's clock signal
 *   VGA_HS 		- Horizontal Sync of the VGA connection
 *   VGA_SYNC_N 	- Enable signal for the sync of the VGA connection
 *   VGA_VS 		- Vertical Sync of the VGA connection
 */
 
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	// unused HEX displays
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	logic [10:0] x0, y0, x1, y1, x, y;
	
	logic reset;
	logic clk;
	
	assign clk = CLOCK_50;
	
	logic write;
	VGA_framebuffer fb (
		.clk50			(clk), 
		.reset			(reset), 
		.x, 
		.y,
		.pixel_color	(1'b1), 
		.pixel_write	(write),
		.VGA_R, 
		.VGA_G, 
		.VGA_B, 
		.VGA_CLK, 
		.VGA_HS, 
		.VGA_VS,
		.VGA_BLANK_n	(VGA_BLANK_N), 
		.VGA_SYNC_n		(VGA_SYNC_N));
				
	line_drawer line (.clk, .reset(reset), .x0, .y0, .x1, .y1, .x, .y, .start(1'b1), .write, .ready());
	synchronizer #(.SIZE(1'b1)) resetSynchronizer (.in(SW[0]), .out(reset), .clk(clk), .reset(1'b0));
	
	assign x0 = 185;
	assign x1 = 200;
	assign y0 = 180;
	assign y1 = 210;
	
endmodule // DE1_SoC

/* testbench for DE1_SoC */
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic clk, CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	logic reset;
	
	assign SW[0] = reset;
	
	assign CLOCK_50 = clk;
	parameter CLOCK_PERIOD = 100;
	
	DE1_SoC dut (.*);
	
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		
		for(integer i = 0; i < 42; i++) begin
			@(posedge clk);
		end
		
		$stop;
	end // initial
endmodule // DE1_SoC_testbench
