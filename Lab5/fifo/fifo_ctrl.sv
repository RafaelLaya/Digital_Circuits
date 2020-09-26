/* Parametrized FIFO Controller module where the writing port
 * is twice as wide than the reading port. Thus each write 
 * performs to writes.
 * 
 * Inputs:
 *   clk			- 1-bit clock signal
 *   reset		- 1-bit reset signal
 *	  rd			- 1-bit read signal. Assert TRUE to read an element. 
 *   wr			- 1-bit write signal. Assert TRUE to write an element.
 *
 * Outputs:
 *   empty     - 1-bit signal asserted TRUE if the FIFO is empty.
 *   full		- 1-bit signal asserted TRUE if the FIFO doesn't
 *					  have space for another write.
 *	  rd_addr	- ADDR_WIDTH signal corresponding to the reading address
 * 				  of the internal memory of this FIFO implementation.
 *   wr_addr	- ADDR_WIDTH signal corresponding to the writing address
 *					  of the internal memory of this FIFO implementation. 
 *  
 * Can be used as a general register file depending on the application.
 * Can also be connected to a FIFO-controller to construct a FIFO-buffer
 * Specifically, one whose writing port is twice as wide as the reading port. 
*/
module fifo_ctrl #(parameter ADDR_WIDTH=4)
                 (clk, reset, rd, wr, empty, full, w_addr, r_addr);

	input  logic clk, reset, rd, wr;
	output logic empty, full;
	output logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] rd_ptr, rd_ptr_next;
	logic [ADDR_WIDTH-1:0] wr_ptr, wr_ptr_next;
	logic empty_next, full_next;
	
	// output assignments
	assign w_addr = wr_ptr;
	assign r_addr = rd_ptr;
	
	// fifo controller logic
	always_ff @(posedge clk) begin
		if (reset)
			begin
				wr_ptr <= 0;
				rd_ptr <= 0;
				full   <= 0;
				empty  <= 1;
			end
		else
			begin
				wr_ptr <= wr_ptr_next;
				rd_ptr <= rd_ptr_next;
				full   <= full_next;
				empty  <= empty_next;
			end
	end  // always_ff
	
	// next state logic
	always_comb begin
		// default to keeping the current values
		rd_ptr_next = rd_ptr;
		wr_ptr_next = wr_ptr;
		empty_next = empty;
		full_next = full;
		case ({rd, wr})
			2'b11:  // read and write
				begin
					rd_ptr_next = rd_ptr + 1'b1;
					wr_ptr_next = wr_ptr + 1'b1;
				end
			2'b10:  // read
				if (~empty)
					begin
						rd_ptr_next = rd_ptr + 1'b1;
						if (rd_ptr_next == wr_ptr)
							empty_next = 1;
						full_next = 0;
					end
			2'b01:  // write
				if (~full)
					begin
						wr_ptr_next = wr_ptr + 1'b1;
						empty_next = 0;
						if (wr_ptr_next == rd_ptr)
							full_next = 1;
					end
			2'b00: ; // no change
		endcase
	end  // always_comb
	
endmodule

/* fifo_ctrl_testbench */
module fifo_ctrl_testbench();
	parameter CLOCK_PERIOD = 100;
	parameter ADDR_WIDTH = 2;
	logic clk, reset, rd, wr;
	logic empty, full;
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic [ADDR_WIDTH-1:0] rd_ptr;
	logic [ADDR_WIDTH-1:0] wr_ptr; 
	
	fifo_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) dut (.*);
	
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
		@(posedge clk);
		reset <= 1'b0;
		
		// try to read when empty 
		rd <= 1'b1;
		@(posedge clk);
		
		// write
		wr <= 1'b1;
		rd <= 1'b0;
		@(posedge clk);
		
		// try to read three times 
		rd <= 1'b1;
		wr <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		// fill buffer and tries to write onto full buffer
		wr <= 1'b1;
		rd <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		// now read and write
		rd <= 1'b1;
		wr <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end // initial
	
endmodule // fifo_ctrl_testbench
