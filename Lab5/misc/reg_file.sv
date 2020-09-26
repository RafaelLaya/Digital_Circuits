/* Parametrized Register File
 *
 * Inputs:
 *   clk			- 1-bit clock signal
 *	  w_data 	- DATA_WIDTH-bits signal of the data to be written
 *   w_en		- 1-bit write enable signal. TRUE when writing is enabled,
 *					  otherwise false.
 *   w_addr    - ADDR_WIDTH-bit signal of the address that will be written
 *  				  when w_en is TRUE.
 *   r_addr    - ADDR_WIDTH-bits signal of the address that will be read
 *
 * Outputs:
 *   r_data		- DATA_WIDTH-bits signal of the read port (asynchronous). 
 *  
 * Can be used as a general register file depending on the application.
*/
module reg_file #(parameter DATA_WIDTH=8, ADDR_WIDTH=2)
                (reset, clk, w_data, w_en, w_addr, r_addr, r_data);

	input  logic clk, w_en, reset;
	input  logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	input  logic [DATA_WIDTH-1:0] w_data;
	output logic [DATA_WIDTH-1:0] r_data;
	
	// array declaration (registers)
	logic [DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1];
	
	// write operation (synchronous)
	always_ff @(posedge clk)
		if(reset) begin
			for(integer i = 0; i < 2**ADDR_WIDTH; i++) array_reg[i] = '0;
		end 
		else if(w_en) array_reg[w_addr] <= w_data;
	
	// read operation (asynchronous)
	assign r_data = array_reg[r_addr];
	
endmodule // reg_file


/* testbench for reg_file */
module reg_file_testbench();
	parameter ADDR_WIDTH = 2;
	parameter DATA_WIDTH = 8;
	parameter CLOCK_PERIOD = 100;
	logic clk, w_en, reset;
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic [DATA_WIDTH-1:0] w_data;
	logic [DATA_WIDTH-1:0] r_data;
	
	reg_file #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (.*);
	
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
		w_en <= 1'b0;
		w_addr <= 2'b00;
		r_addr <= 2'b00;
		w_data <= 8'h00;
		@(posedge clk);
		
		// write a pattern
		w_en <= 1'b1;
		w_data <= 8'hAA;
		w_addr <= 2'b00;
		@(posedge clk);
		
		w_data <= 8'hBB;
		w_addr <= 2'b01;
		@(posedge clk);
		
		w_data <= 8'hCC;
		w_addr <= 2'b10;
		@(posedge clk);
		
		w_data <= 8'hDD;
		w_addr <= 2'b11;
		@(posedge clk);
		
		// now read memory
		for (integer i = 0; i < 4; i++) begin
			w_en <= 1'b0;
			r_addr <= 2'(i);
			@(posedge clk);
		end // for
		
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end // initial
endmodule // reg_file_testbench