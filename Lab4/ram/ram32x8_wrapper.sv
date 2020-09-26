/* Wrapper module for a 32x4 (32 words, 4-bits each) RAM module
 * Input is registered 
 * 
 * Inputs:
 *   address    - 5-bit address for writing (wren TRUE) or reading
 *   din        - 8-bit word to write (enabled when wren is TRUE)
 *   clk        - 1-bit clock signal
 *   wren       - 1-bit signal that is TRUE when writing is enabled
 *                      otherwise FALSE
 *
 * Outputs:
 *   dout       - 8-bit data output to read
 *  
 * Multi-purpose memory, could be connected to anything that
 * requires a 32x4 RAM module. 
*/
module ram32x8_wrapper(clk, reset, addr, dout, wren, data);
	input logic clk, reset;
	input logic [4:0] addr;
	output logic [7:0] dout;
	
	input logic wren;
	input logic [7:0] data;
	ram32x8 memory (.address(addr), .clock(clk), .data(data), .wren(wren), .q(dout));

endmodule

/* testbench for ram32x8_wrapper */
`timescale 1 ps / 1 ps
module ram32x8_wrapper_testbench();
	logic clk, reset;
	logic [4:0] addr;
	logic [7:0] dout;
	
	logic wren;
	logic [7:0] data;
	
	ram32x8_wrapper dut (.*);
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(100);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		reset <= 1'b1;
		data <= 7'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// read the memory
		for(integer i = 0; i < 32; i++) begin
			wren <= 1'b0;
			addr <= 5'(i);
			@(posedge clk);
		end // for
		
		@(posedge clk);
		
		$stop;
	end // initial
endmodule // ram32x8_wrapper_testbench