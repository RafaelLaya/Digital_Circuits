/* Binary searcher module
 * 
 * Inputs:
 *		clk			- 1-bit clock signal
 *		reset			- 1-bit active-high reset signal
 *		start			- 1-bit active-high start search signal
 *
 * Outputs:
 *		done			- 1-bit active-high signal that tells user the computation is done
 *		found			- 1-bit active-high signal that tells the user the target has been found
 *		userData		- 8-bits of the target to be found in memory
 *		m 				- 5-bit address where userData is (valid if found is TRUE)
 *
 * Can be used to find an element in my_array.mif
*/
module binary_searcher(clk, reset, done, found, start, userData, m, ready);
	input logic clk, reset, start;
	output logic done, found, ready;
	output logic [4:0] m;
	input logic [7:0] userData;

	logic init, calc_m, move_L, move_R;
	logic [7:0] currentItem, target;
	logic signed [6:0] left, right;
	binary_searcher_controller controller (.clk, .reset, .start, .done, .found, .init, .calc_m, .move_L, .move_R, .currentItem, .target, .left, .right, .ready);
	
	logic [7:0] memoryData;
	binary_searcher_datapath datapath (.clk, .reset, .init, .calc_m, .move_L, .move_R, .currentItem, .target, .left, .right, .memoryData, .userData, .m);
	
	ram32x8 memory (.address(m), .clock(clk), .data(), .wren(1'b0), .q(memoryData));

endmodule // binary_searcher

/* testbench for binary_searcher */
`timescale 1 ps / 1 ps
module binary_searcher_testbench();
	logic clk, reset, start;
	logic [7:0] userData;
	logic done, found, ready;
	logic [4:0] m;
	logic [7:0] expectedIndex;
	
	// {a, b} where a is the target, and b is the index where it should be found
	// 255 means Not found within this testbench
	localparam logic [15:0] array[0:6] = {{8'd10, 8'd0}, 
													  {8'd65, 8'd31},
													  {8'd70, 8'd255},
													  {8'd20, 8'd255},
													  {8'd32, 8'd255}, 
													  {8'd58, 8'd26},
													  {8'd60, 8'd27}};
	
	binary_searcher dut (.*);
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
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
		userData <= 0;
		@(posedge clk);
		reset <= 1'b0;
		
		// go through the test cases
		for(integer i = 0; i < 7; i++) begin
			{userData, expectedIndex} <= array[i];
			start <= 1'b1;
			@(posedge clk);
			@(posedge done);
			start <= 1'b0;
			@(posedge clk);
		end // for
		
		$stop;
	end // initial
endmodule // binary_searcher_testbench