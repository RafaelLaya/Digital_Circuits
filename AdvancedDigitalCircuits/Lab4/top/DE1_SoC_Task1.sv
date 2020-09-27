/* Top level module of the FPGA that uses bit_counter to display
 * the number of bits SET from SW[7:0] in HEX0
 *
 * Inputs:
 *		SW[7:0]		- Data input whose bits will be counted
 *		SW[9]			- Active-high start signal
 *		KEY[0]		- Pressing KEY[0] resets the system
 *		CLOCK_50		- Clock signal of the system
 *
 * Outputs:
 *		HEX0			- Bits counted from input SW[7:0]
 *		LEDR9			- LED is ON when the algorithm has finished computing
 *						  the number of bits set in SW[7:0]
 */
module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	// unused LEDRs and HEX displays
	assign HEX5 = '1;
	assign HEX4 = '1;
	assign HEX3 = '1;
	assign HEX2 = '1;
	assign HEX1 = '1;
	assign LEDR[8:0] = '0;
	
	// internal signals
	logic reset;
	logic clk;
	logic [7:0] in;
	logic start;
	logic done;
	logic [3:0] result;
	
	// make reset happen when KEY[0] is pressed
	assign reset = ~KEY[0];
	
	// use CLOCK_50 as clock
	assign clk = CLOCK_50;
	
	// feedback for when the computation is done
	assign LEDR[9] = done;
	
	// synchronize external inputs to avoid meta-stability
	synchronizer #(.SIZE(8)) inputSync (.in(SW[7:0]), .out(in), .clk(clk), .reset(reset));
	synchronizer #(.SIZE(1)) startSync (.in(SW[9]), .out(start), .clk(clk), .reset(reset));
	
	// make the interconnections
	bit_counter counter (.clk, .reset, .start, .in, .done(done), .result);
	seg7 display (.bcd(result), .leds(HEX0)); 
	
endmodule // DE1_SoC

/* testbench for DE1_SoC */
module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic clk, CLOCK_50;
	logic reset;
	logic [7:0] in;
	logic start, done;
	logic result;
	logic [3:0] count;
	
	assign CLOCK_50 = clk;
	assign KEY[0] = ~reset;
	assign SW[7:0] = in;
	assign SW[9] = start;
	assign done = LEDR[9];
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	DE1_SoC dut (.*);
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		start <= 1'b0;
		in <= 8'b0000_0000;
		@(posedge clk);
		reset <= 1'b0;
		
		// test numbers from 20 to 24
		for (integer i = 20; i < 25; i++) begin
			in <= 8'(i);
			@(posedge clk);
			start <= 1'b1;
			@(posedge clk);
			@(posedge done);
			start <= 1'b0;
			@(posedge clk);
		end // for
		
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // DE1_SoC_testbench
