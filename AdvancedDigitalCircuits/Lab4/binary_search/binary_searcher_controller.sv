/* Controller module for a binary search module
 * 
 * Inputs:
 *		clk			- 1-bit clock signal
 *		reset			- 1-bit active-high reset signal
 *		start			- 1-bit active-high start signal to initiate binary search
 *		currentItem	- 8-bit status signal of the current item at location m in memory
 *		target		- 8-bit value of the element to search for
 *		left			- 7-bit left-most index of the current search. Signed and one bit bigger
 *						  than necessary to simplify the logic
 *		right			- 7-bit right-most index of the current search. Signed nad one bit bigger
 *						  than necessary to simplify the logic
 *
 * Outputs:
 *		done			- 1-bit active-high signal that signals end of computation
 *		calc_m		- 1-bit active-high control signal that tells datapath to calculate middle index
 *		move_L		- 1-bit active-high control signal that tells datapath to move the left index to m+1
 *		move_R		- 1-bit active-high control signal that tells datapath to move the right index to m-1
 *		found			- 1-bit active-high signal that tells user target has been found
 *		init			- 1-bit active-high control signal that tells datapath to initialize target, L, and R
 *
 * Connected to datapath inside binary_searcher to provide full binary search functionality
*/

module binary_searcher_controller(clk, reset, start, done, found, init, calc_m, move_L, move_R, currentItem, target, left, right, ready);
	// external signals
	input logic clk, reset, start;
	output logic done;
	output logic found, ready;
	
	// control signals
	output logic init, calc_m, move_L, move_R;
	
	// status signals
	input logic [7:0] currentItem, target;
	input logic signed [6:0] left, right;
	
	// states
	enum {IDLE, COMPUTING, FINISHING, FETCHING, WAITING, DECIDING} ps, ns;
	
	// state transition
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	// next state logic
	always_comb begin
		case(ps) 
			IDLE: begin
				if(start) ns = COMPUTING;
				else ns = IDLE;
			end // IDLE
			
			COMPUTING: begin
				if(!(left <= right)) ns = FINISHING;
				else ns = FETCHING;
			end // COMPUTING
			
			FINISHING: begin
				if(start) ns = FINISHING;
				else ns = IDLE;
			end // FINISHING
			
			FETCHING: begin
				ns = WAITING;
			end // FETCHING
			
			WAITING: begin
				ns = DECIDING;
			end // WAITING
			
			DECIDING: begin
				if(currentItem == target) ns = FINISHING;
				else ns = COMPUTING;
			end // DECIDING
			
			default: begin
				ns = IDLE;
			end // default
		endcase // case(ps)
	end // always_comb
	
	// done logic
	always_comb begin
		if(ps == FINISHING) done = 1'b1;
		else done = 1'b0;
	end // always_comb
	
	// found logic
	always_comb begin
		if((ps == DECIDING) && (currentItem == target)) found = 1'b1;
		else if ((ps == FINISHING) && (currentItem == target)) found = 1'b1;
		else found = 1'b0;
	end // always_comb
	
	// init logic
	always_comb begin
		if((ps == IDLE) && (start)) init = 1'b1;
		else init = 1'b0;
	end // always_comb
	
	// calc_m logic
	always_comb begin
		if((ps == COMPUTING) && (left <= right)) calc_m = 1'b1;
		else calc_m = 1'b0;
	end // always_comb
	
	// move_L logic
	always_comb begin
		if((ps == DECIDING) && (currentItem < target)) move_L = 1'b1;
		else move_L = 1'b0;
	end // always_comb
	
	// move_R logic
	always_comb begin
		if((ps == DECIDING) && (currentItem > target)) move_R = 1'b1;
		else move_R = 1'b0;
	end // always_comb
	
	// ready logic
	assign ready = (ps == IDLE);
endmodule // binary_searcher_controller

/* testbench for binary_searcher */
module binary_searcher_controller_testbench();
	logic clk, reset, start;
	logic [7:0] currentItem, target;
	logic signed [6:0] left, right;
	logic done;
	logic found, ready;
	logic init, calc_m, move_L, move_R;
	
	binary_searcher_controller dut (.*);
	
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
		start <= 1'b0;
		currentItem <= '0; 
		left <= '0; 
		right <= '0; 
		target <= '0; 
		@(posedge clk);
		reset <= 1'b0;
		
		// simulate datapath status, we'll find the element at index 6
		// the element is 100 (target)
		left <= 0;
		right <= 31;
		target <= 100;
		currentItem <= 255;
		@(posedge clk);
		start <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		right <= 14;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		right <= 6;
		@(posedge clk);
		currentItem <= 10;
		@(posedge clk);
		@(posedge clk);
		left <= 4;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		left <= 6;
		@(posedge clk);
		currentItem <= 100;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		start <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		// Now try searching for a non-existing value
		currentItem <= 255;
		target <= 100;
		left <= 5;
		right <= 4;
		start <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		start <= 1'b0;
		@(posedge clk);
		@(posedge clk);
		$stop;
	end // initial
endmodule // binary_searcher_controller_testbench