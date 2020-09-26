/* Finite Impulse Response Filter
 * 
 * Inputs:
 *   	clk 			- 1-bit clock signla
 *		reset			- 1-bit active-high synchronous reset signal
 *		din			- 24-bits of input data
 *    en				- 1-bit active- high enable signal
 *
 * Output:
 *    dout			- 24-bits of output data
 */
module FIR_Fifo #(parameter SIZE=8, LOG_SIZE=3) (clk, reset, din, dout, en);
	input logic clk, reset, en;
	input logic signed [23:0] din;
	output logic signed [23:0] dout;
	
	logic signed [23:0] din_div, fifo_out, din_ac, ac_in, ac_out;
	
	// signals derived from the diagram
	assign din_div = din / SIZE;
	assign din_ac = din_div - fifo_out;
	assign ac_in = ac_out + din_ac;
	assign dout = ac_in;
	
	// fifo for the data
   fifo #(.DATA_WIDTH(24), .ADDR_WIDTH(LOG_SIZE)) data_fifo (.clk, .reset, .rd(en), .wr(en), .empty(), .full(), .w_data(din_div), .r_data(fifo_out));
	
	// accumulator
	register #(.N(24)) accumulator (.clk, .reset, .in(ac_in), .out(ac_out), .en);
endmodule // FIR_8

/* testbench for FIR_Fifo */
module FIR_Fifo_testbench();
	logic clk, reset, en;
	logic signed [23:0] din;
	logic signed [23:0] dout;
	
	parameter CLOCK_PERIOD = 100;
	parameter N = 3;
	
	FIR_Fifo #(.SIZE(2 ** N), .LOG_SIZE(N)) dut (.*);
	
	integer expected;
	
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
		en <= 1'b0;
		din <= 'b0;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		
		// fill the registers with an initial value
		en <= 1'b1;
		din <= 24'(30); @(posedge clk);
		din <= 24'(40); @(posedge clk);
		din <= 24'(50); @(posedge clk);
		din <= 24'(60); @(posedge clk);
		din <= 24'(70); @(posedge clk);
		din <= 24'(80); @(posedge clk);
		din <= 24'(90); @(posedge clk);
		
		for(integer i = 100; i < 201; i = i + 10) begin
				en <= 1'b1;
				din <= 24'(i);
				
				expected = 0;
				for(integer k = 0; k < 8; k++) begin
					expected = expected + (i - k * 10) / 8;
				end // for over k
				
				@(posedge clk);
				
				assert(dout == expected) $display("Success. Expected: %5d, Got: %5d", expected, dout);
				else $error("Error. Expected: %5d, Got: %5d", expected, dout);
		end // for over i
		
		// test the enable signal
		en <= 1'b0;
		din <= 24'd0;
		@(posedge clk);
		din <= 24'd210;
		en <= 1'b1;
		@(posedge clk);
		$stop;
	end // initial
endmodule // FIR_Fifo_testbench