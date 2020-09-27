/* 1-Bit D Flip-Flop with synchronous reset on positive edge of clock
 * 
 * Inputs:
 *   in    - 1-bit input (By convention called D) 
 *   reset - 1-bit reset signal
 *   clk   - 1-bit clock signal
 *
 * Outputs:
 *   out   - 1-bit output (By convention called Q)
 *  
 * Very often connected in series with other DFFs to make shift registers, or 
 * in parallel to make registers with parallel load.
 * Often used in Finite State Machines for remembering states.
 * Two of these can be put in series to protect the system from meta-stability
 * from external inputs (i.e.: Buttons, switches, etc.) 
*/
module D_FF(out, in, reset, clk);
	output logic out;
	input logic in;
	input logic reset, clk;
	
	// output/state logic
	always_ff @(posedge clk) begin
		if(reset) out <= 1'b0;
		else  out <= in;
	end // always_ff (output/state logic)
endmodule // D_FF

/* testbench for D_FF */
module D_FF_testbench();
	logic out, in, reset, clk;
	
	// set up the clock
	parameter PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(PERIOD / 2) clk <= ~clk;
		end // forever 
	end // initial
	
	D_FF dut(.*);
	
	initial begin
		// reset the system to a known state
		reset <= 1'b1;
		in <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		
		// Will tests every possible case
		// tests holding 0 and writing 0
		in <= 1'b0;
		@(posedge clk);
		
		// tests holding 0 and writing 1
		in <= 1'b1;
		@(posedge clk);
		
		// tests holding 1 and writing 1
		in <= 1'b1;
		@(posedge clk);
		
		// tests holding 1 and writing 0
		in <= 1'b0;
		@(posedge clk);
		
		
		@(posedge clk);
		$stop;
	end // initial
endmodule // D_FF_testbench