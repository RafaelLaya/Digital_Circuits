/* Wrapper module for a 32x4 (32 words, 4-bits each) RAM module
 * with separate input and output ports. The input is registered
 * 
 * Inputs:
 *   address    - 5-bit address for writing (wren TRUE) or reading
 *   din        - 4-bit word to write (enabled when wren is TRUE)
 *   clk        - 1-bit clock signal
 *   wren       - 1-bit signal that is TRUE when writing is enabled
 *                      otherwise FALSE
 *
 * Outputs:
 *   dout       - 4-bit data output used for reading
 *  
 * Multi-purpose memory, could be connected to anything that
 * requires a 32x4 RAM module. 
*/
module ram32x4_wrapper(address, din, dout, wren, clk);
	input logic [4:0] address;
	input logic clk;
	input logic [3:0] din;
	input logic wren;
	output logic [3:0] dout; 
	
	ram32x4 memory (.address(address), .clock(clk), .data(din), 
						 .wren(wren), .q(dout));
	
endmodule // ram32x4_wrapper

/* testbench for ram32x4_wrapper */
`timescale 1 ps / 1 ps
module ram32x4_wrapper_testbench();
	logic [4:0] address;
	logic clk;
	logic [3:0] din;
	logic wren;
	logic [3:0] dout;
	parameter CLOCK_PERIOD = 100;
	
	ram32x4_wrapper dut (.*);
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		
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
	
endmodule // ram32x4_wrapper_testbench
