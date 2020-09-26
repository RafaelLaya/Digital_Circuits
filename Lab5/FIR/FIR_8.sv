/* Finite Impulse Response Filter
 * 
 * Inputs:
 *   	clk 			- 1-bit clock signla
 *		reset			- 1-bit active-high synchronous reset signal
 *		din			- 24-bits of input data
 *    en				- 1-bit active-high enable signal for the registers
 *
 *
 * Output:
 *    dout 			- 24-bits of output data
 *
 *  Can be connected to an audio CODEC interface to filter sound before
 *  going to the line-out line
 */
module FIR_8(clk, reset, din, dout, en);
	input logic clk, reset, en;
	input logic signed [23:0] din;
	output logic signed [23:0] dout;
	
	// Entry [i] in the packed dimension refers to the input of register i, 
	// Thus [i + 1] refers to the output of register i
	logic signed [23:0] buffer [0:7];
	assign buffer[0] = din;
	
	genvar i;
	generate
		for(i = 0; i < 7; i++) begin: eachReg
			// reg_i is the ith register of this FIR
			register #(.N(24)) reg_i (.clk, .reset, .in(buffer[i]), .out(buffer[i + 1]), .en(en)); 
		end // for 
	endgenerate // generate over i
	
	// Calculate the output
	always_comb begin 
		dout = 0;
		for(integer i = 0; i < 8; i++) begin
			dout = (dout + (buffer[i] / 8));
		end // end
	end // always_comb
	
endmodule // FIR_8

/* testbench for FIR_8 */
module FIR_8_testbench();	
	logic clk, reset, en;
	logic signed [23:0] din, dout;
	parameter CLOCK_PERIOD = 100;
	
	FIR_8 dut (.*);
	
	// set-up clock
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	integer expected;
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
				@(posedge clk);
				
				expected = 0;
				for(integer k = 0; k < 8; k++) begin
					expected = expected + (i - k * 10) / 8;
				end // for over k
				
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
endmodule // FIR_8_testbench

