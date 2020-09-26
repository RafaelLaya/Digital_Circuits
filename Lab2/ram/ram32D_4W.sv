/* 32x4 (32 words, 4-bits each) RAM module
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
 *   dout       - 4-bit data output to read
 *  
 * Multi-purpose memory, could be connected to anything that
 * requires a 32x4 RAM module. 
*/
module ram32D_4W(addr, din, dout, wren, clk);
	input logic clk;
	input logic [4:0] addr;
	input logic [3:0] din;
	input logic wren;
	output logic [3:0] dout; 
	
	logic [3:0] RAM[31:0];
	

	always_ff @(posedge clk) begin
		if(wren) begin
			RAM[addr] <= din;
			dout <= din;
		end // if(wren)
		else begin
			dout <= RAM[addr];
		end // else
	end // always_ff
	
endmodule // ram32D_4W

/* testbench for ram32D_4W */
`timescale 1 ps / 1 ps
module ram32D_4W_testbench();
	logic clk;
	logic [4:0] addr;
	logic [3:0] din;
	logic wren;
	logic [3:0] dout; 
	parameter CLOCK_PERIOD = 100;
	
	ram32D_4W dut (.*);
	
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
		addr <= 5'b00000;
		din <= 4'b1010;
		@(posedge clk);
		
		// writes 1111 to 00010
		wren <= 1'b1;
		addr <= 5'b00010;
		din <= 4'b1111;
		@(posedge clk);
		
		// writes 0101 to 00101
		wren <= 1'b1;
		addr <= 5'b00101;
		din <= 4'b0101;
		@(posedge clk);
		@(posedge clk);
		
		// reads 1010 in 00000
		wren <= 1'b0;
		addr <= 5'b00000;
		@(posedge clk);
		
		// reads 1111 in 00010
		addr <= 5'b00010;
		@(posedge clk);
		
		// reads 0101 in 00101
		addr <= 5'b00101;
		@(posedge clk);
		@(posedge clk);
		
		// overwrites the old 1111 in 00010 by 0000
		wren <= 1'b1;
		addr <= 5'b00010;
		din <= 4'b0000;
		@(posedge clk);
		@(posedge clk);
		
		// checks the overwrite took effect
		wren <= 1'b0;
		addr <= 5'b00010;
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end // initial
	
endmodule // ram32D_4W_testbench
	