/* Parametrized FIFO module
 * 
 * Inputs:
 *   clk			- 1-bit clock signal
 *	  reset		- 1-bit reset signal
 *   rd			- 1-bit read signal. Assert TRUE to read.
 *   wr			- 1-bit write signal. Assert TRUE to write. 
 *   w_data		- DATA_WIDTH-bits signal that corresponds to the
 *					  address to write.
 *
 * Outputs:
 *   empty		- 1-bit signal that is TRUE when the FIFO is empty.
 *					  otherwise FALSE.
 *   full		- 1-bit signal that is TRUE when the FIFO is full.
 *					  otherwise FALSE.
 *   r_data		- DATA_WIDTH-bits signal that corresponds to the 
 *					  data being read. 
 *  
 * This is a FIFO buffer. Can be used to construct an N-bits
 * FIR 
*/
module fifo #(parameter DATA_WIDTH=8, ADDR_WIDTH=4)
            (clk, reset, rd, wr, empty, full, w_data, r_data);

	input  logic clk, reset, rd, wr;
	output logic empty, full;
	input  logic [DATA_WIDTH-1:0] w_data;
	output logic [DATA_WIDTH-1:0] r_data;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic w_en;
	
	// enable write only when FIFO is not full
	assign w_en = wr & (~full | rd);
	
	// instantiate FIFO controller and register file
	fifo_ctrl #(ADDR_WIDTH) c_unit (.*);
	reg_file #(DATA_WIDTH, ADDR_WIDTH) r_unit (.*);
	
endmodule // fifo

/* testbench for fifo */
module fifo_testbench();
	logic clk, reset, rd, wr;
	logic empty, full;
	
	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 4;
	parameter CLOCK_PERIOD = 100;
	logic [DATA_WIDTH-1:0] r_data;
	logic [DATA_WIDTH-1:0] w_data;
	
	fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (.*);
	
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
		// reset system to a known state
		reset <= 1'b1;
		rd <= 1'b0;
		wr <= 1'b0;
		w_data <= 8'b0000_0000;
		@(posedge clk);
		reset <= 1'b0;
		
		// no read no write
		@(posedge clk);
		
		wr <= 1'b1;
		rd <= 1'b0;
		// fill the buffer by only writing
		for (integer i = 0; i < 10; i++) begin
			w_data <= 8'(i);
			@(posedge clk);
		end
		
		// read the data
		wr <= 1'b0;
		rd <= 1'b1;
		for (integer i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		$stop;
		
	end // initial
	
endmodule // fifo_testbench

