/* Filters the output of keyboard_press_driver, so that out indicates if a key is being pressed
 *
 * Parameters:
 *		MAKE						- MAKE-code to monitor
 *		BREAK						- BREAK-code to monitor
 *
 * Inputs:
 *   	clk						- Clock signal
 *		reset						- active-high reset signal
 *		valid						- active-high signal indicates if outCode and makeBreak are valid. Connect to
 *									  signal of same name in keyboard_press_driver
 *		makeBreak				- active-high signal indicates if outCode is a make-code. Connect to signal
 *									  of the same name in keyboard_press_driver
 *		outCode					- make/break code depending on makeBreak. Connect to signal of same name in
 *									  keyboard-press_driver
 *
 * Outputs:
 *   	out						- active-high signal indicates the key is being pressed
 */

module keyboard_input_filter #(parameter MAKE=8'h00, BREAK=8'h00) (clk, reset, valid, makeBreak, outCode, out);
	input logic clk, reset, valid, makeBreak;
	input logic [7:0] outCode;
	output logic out;
	
	enum {IDLE, HOLDING} ps, ns;
	
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	always_comb begin
		case(ps)
			IDLE: begin
				if(valid && makeBreak && outCode == MAKE) ns = HOLDING;
				else ns = IDLE;
			end // IDLE
			
			HOLDING: begin
				if(valid && !makeBreak && outCode == BREAK) ns = IDLE;
				else ns = HOLDING;
			end // HOLDING
			
			default: ns = IDLE;
		endcase // case(ps)
	end // always_comb
	
	assign out = (ps == HOLDING);
	
endmodule // keyboard_input_filter

/* testbench for keyboard_input_filter */
module keyboard_input_filter_testbench();
	logic clk, reset, valid, makeBreak;
	logic [7:0] outCode;
	logic out;
	parameter MAKE=8'hAA;
	parameter BREAK=8'hBB;
	
	keyboard_input_filter #(.MAKE(MAKE), .BREAK(BREAK)) dut (.*);
	
	// simulate the clock
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
		reset <= 1'b1;
		valid <= 1'b0;
		makeBreak <= 1'b0;
		outCode <= '0;
		@(posedge clk);
		reset <= 1'b0;
		
		// invalid press
		valid <= 1'b0;
		makeBreak <= 1'b1;
		outCode <= MAKE;
		repeat (5) @(posedge clk);
		
		// press the key
		valid <= 1'b1;
		outCode <= MAKE;
		repeat (5) @(posedge clk);
		
		// fail to release the key
		valid <= 1'b0;
		outCode <= BREAK;
		repeat (5) @(posedge clk);
		
		// now release the key
		valid <= 1'b1;
		outCode <= BREAK;
		makeBreak <= 1'b0;
		repeat (5) @(posedge clk);
		
		$stop;
	end // initial
endmodule // keyboard_input_filter_testbench