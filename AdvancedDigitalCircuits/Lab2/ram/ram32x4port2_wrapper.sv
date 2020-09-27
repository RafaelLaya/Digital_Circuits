/* Wrapper module for a 32x4 (32 words, 4-bits each) RAM module
 * with separate bus for reading and writing. Input is registered. 
 * 
 * Inputs:
 *   rd_addr    - 5-bit address for reading
 *   wr_addr    - 5-bit address for writing
 *   clk        - 1-bit clock signal
 *   din        - 4-bit data to write when wren is TRUE
 *   wren       - 1-bit signal that is TRUE when writing is enabled
 *                      otherwise FALSE
 *
 * Outputs:
 *   dout       - 4-bit data output to read
 *  
 * Multi-purpose memory, could be connected to anything that
 * requires a 32x4 RAM module. 
*/

module ram32x4port2_wrapper(clk, din, rd_addr, wr_addr, wren, dout);
	input logic clk;
	input logic [3:0] din;
	input logic [4:0] rd_addr;
	input logic [4:0] wr_addr;
	input logic wren;
	output logic [3:0] dout;
	
	ram32x4port2 memory (.clock(clk), .data(din),
								.rdaddress(rd_addr), 
								.wraddress(wr_addr), 
								.wren(wren), 
								.q(dout));

endmodule // ram32x4port2_wrapper

/* testbench for ram32x4port2_wrapper */
`timescale 1 ps / 1 ps
module ram32x4port2_wrapper_testbench();
	logic clk;
	logic [3:0] din;
	logic [4:0] rd_addr;
	logic [4:0] wr_addr;
	logic wren;
	logic [3:0] dout;
	parameter CLOCK_PERIOD = 100;
	
	ram32x4port2_wrapper dut (.*);
	
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
		din <= 4'b0000;
		rd_addr <= 5'b0000;
		wr_addr <= 5'b0000;
		wren <= 1'b0;
		@(posedge clk);
		
		// write last addr to check writing works
		wr_addr <= 5'b11111;
		din <= 4'b1111;
		wren <= 1'b1;
		@(posedge clk);
		wren <= 1'b0;
		
		// read contents 
		for(int addr = 0; addr < 32; addr++) begin
			rd_addr <= addr;
			@(posedge clk);
		end
		
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // ram32x4port2_wrapper_testbench