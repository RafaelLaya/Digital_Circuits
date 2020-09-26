/* Selects which screen is shown on the VGA display                       
 * 
 * Inputs:
 *   	clk				- Clock signal
 *		reset				- active-high reset signal
 *		collision		- active-high signal indicates a collision occurred
 *		move				- active-high pulses synchronizes game elements 
 *
 * Outputs:
 *   	floor_offset	- Offset of the floor sprite to produce an animation
 *                                              
*/
module floor_animator(clk, reset, floor_offset, collision, move);
	input logic clk, reset, collision, move;
	output logic [11:0] floor_offset;
	
	always_ff @(posedge clk) begin
		if(reset) floor_offset <= 0;
		else if(collision) floor_offset <= floor_offset;
		else if(floor_offset >= 640) floor_offset <= 0;
		else if(move) floor_offset <= floor_offset + 12'd1;
	end // always_ff
endmodule // floor_animator

/* testbench for floor_animator */
module floor_animator_testbench();
	logic clk, reset, collision, move;
	logic [11:0] floor_offset;
	
	floor_animator dut (.*);
	
	// simulated clock
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
		collision <= 1'b0;
		move <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// moves on move
		repeat (5) @(posedge clk);
		move <= 1'b1;
		repeat (5) @(posedge clk);
		
		// stops moving on collision
		collision <= 1'b1;
		repeat (5) @(posedge clk);
		
		$stop;
	end // initial
endmodule // floor_animator_testbench