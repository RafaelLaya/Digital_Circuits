/* Controller module for a binary search module
 * 
 * Inputs:
 *		clk			- 1-bit clock signal
 *		reset			- 1-bit active-high reset signal
 *		memoryData	- 8-bit data from the memory at address m
 *		userData		- 8-bit data from the user (value that will be searched)
 *		calc_m		- 1-bit active-high control signal that tells datapath to calculate middle index
 *		move_L		- 1-bit active-high control signal that tells datapath to move the left index to m+1
 *		move_R		- 1-bit active-high control signal that tells datapath to move the right index to m-1
 *		found			- 1-bit active-high signal that tells user target has been found
 *		init			- 1-bit active-high control signal that tells datapath to initialize target, L, and R
 *
 * Outputs:
 *		currentItem	- 8-bit status signal of the current item at location m in memory
 *		target		- 8-bit value of the element to search for
 *		left			- 7-bit left-most index of the current search. Signed and one bit bigger
 *						  than necessary to simplify the logic
 *		right			- 7-bit right-most index of the current search. Signed nad one bit bigger
 *						  than necessary to simplify the logic
 *
 * Connected to controller inside binary_searcher to provide full binary search functionality.
 * m should be connected to the read-address port of a 32x8 RAM module
*/

module binary_searcher_datapath(clk, reset, init, calc_m, move_L, move_R, currentItem, target, left, right, memoryData, userData, m);
	// external signals
	input logic clk, reset;
	input logic [7:0] memoryData;
	input logic [7:0] userData;
	
	// control signals
	input logic init, calc_m, move_L, move_R;
	
	// status signals
	output logic [7:0] currentItem, target;
	output logic signed [6:0] left, right;
	
	// internal signals
	output logic [4:0] m;
	
	// currentItem logic
	assign currentItem = memoryData;
	
	// target logic
	always_ff @(posedge clk) begin
		if(reset) target <= 8'd0;
		else if(init) target <= userData;
		else target <= target;
	end // target
	
	// left logic
	always_ff @(posedge clk) begin
		if(reset) left <= 5'd0;
		else if(init) left <= 5'd0;
		else if(move_L) left <= m + 1;
		else left <= left;
	end // always_ff
	
	// right logic
	always_ff @(posedge clk) begin
		if(reset) right <= 5'd0;
		else if(init) right <= 5'd31;
		else if(move_R) right <= m - 1;
		else right <= right;
	end // always_ff
	
	// m logic
	always_ff @(posedge clk) begin
		if(reset) m <= 5'd0;
		else if(calc_m) m <= (left + right) / 2;
		else m <= m;
	end // always_ff
	
endmodule // binary_searcher_datapath

/* testbench for binary_searcher_datapath */
module binary_searcher_datapath_testbench();
	logic clk, reset;
	logic [7:0] memoryData;
	logic [7:0] userData;
	logic init, calc_m, move_L, move_R;
	
	logic [7:0] currentItem, target;
	logic signed [6:0] left, right;
	logic [4:0] m;
	
	binary_searcher_datapath dut (.*);
	
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
		memoryData <= 0;
		userData <= 0;
		calc_m <= 0;
		init <= 0;
		move_L <= 0;
		move_R <= 0;
		@(posedge clk);
		reset <= 1'b0;
		
		// test init
		init <= 1;
		userData <= 100;
		@(posedge clk);
		init <= 0;
		
		// Will search for item 100 at index 6
		// Search left twice
		calc_m <= 1;
		@(posedge clk);
		calc_m <= 0;
		memoryData <= 120;
		@(posedge clk);
		move_R <= 1;
		@(posedge clk);
		move_R <= 0;

		calc_m <= 1;
		@(posedge clk);
		calc_m <= 0;
		memoryData <= 110;
		@(posedge clk);
		move_R <= 1;
		@(posedge clk);
		move_R <= 0;
			
		// Search right twice
		calc_m <= 1;
		@(posedge clk);
		calc_m <= 0;
		memoryData <= 90;
		@(posedge clk);
		move_L <= 1;
		@(posedge clk);
		move_L <= 0;
		
		calc_m <= 1;
		@(posedge clk);
		calc_m <= 0;
		memoryData <= 99;
		@(posedge clk);
		move_L <= 1;
		@(posedge clk);
		move_L <= 0;
		
		// Found
		calc_m <= 1;
		@(posedge clk);
		calc_m <= 0;
		memoryData <= 100;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // binary_searcher_datapath_testbench