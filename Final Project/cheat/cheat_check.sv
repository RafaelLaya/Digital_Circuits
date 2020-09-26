/* Monitors the keyboard for a cheat code. A cheat code is produced by pressing 5 particular keys at the same
 * time
 * 
 * Parameters: 
 *		L0, L1, L2, L3, L4			- Code for each of the keys that must be pressed to activate/de-activate the cheat
 *
 * Inputs:
 *   	reset 			- active-high reset signal
 *  	clk   			- clock signal
 *	  	playing			- active-high signal that indicates the game is being played
 *		collision		- active-high signal that indicates a collision has occurred
 *		makeBreak		- active-high signal that indicates outCode is make or break. Connect to
 *							  signal of same name from keyboard_press_driver
 *		valid				- active-high signal that indicates outCode and makeBreak are valid. 
 *							  Connect to signal of same name from keyboard_press_driver
 *		outCode			- code received from the keyboard. Connect to signal of same name from
 *							  keyboard_press_driver
 *
 * Outputs:
 *   out   				- active-high signal that indicates the code is activated
 *  
 *
*/
module cheat_check #(parameter L0=8'h21, L1=8'h33, L2=8'h43, L3=8'h4B, L4=8'h4B) (clk, reset, outCode, makeBreak, valid, out, playing, collision);
	input logic clk, reset, playing, collision;
	input logic [7:0] outCode;
	input logic makeBreak, valid;
	output logic out;
	
	logic out0, out1, out2, out3, out4;
	keyboard_input_filter #(.MAKE(L0), .BREAK(L0)) filter_L0 (.clk, .reset, .valid, .makeBreak, .outCode, .out(out0));
	keyboard_input_filter #(.MAKE(L1), .BREAK(L1)) filter_L1 (.clk, .reset, .valid, .makeBreak, .outCode, .out(out1));
	keyboard_input_filter #(.MAKE(L2), .BREAK(L2)) filter_L2 (.clk, .reset, .valid, .makeBreak, .outCode, .out(out2));
	keyboard_input_filter #(.MAKE(L3), .BREAK(L3)) filter_L3 (.clk, .reset, .valid, .makeBreak, .outCode, .out(out3));
	keyboard_input_filter #(.MAKE(L4), .BREAK(L4)) filter_L4 (.clk, .reset, .valid, .makeBreak, .outCode, .out(out4));

	enum {WAIT, RELEASING_TO_CHEAT, RELEASING_TO_WAIT, CHEATING} ps, ns;
	
	always_ff @(posedge clk) begin
		if(reset) ps <= WAIT;
		else ps <= ns;
	end // always_ff
	
	always_comb begin
		case(ps)
			WAIT: begin
				if(!playing || collision) ns = WAIT;
				else if(out0 && out1 && out2 && out3 && out4) ns = RELEASING_TO_CHEAT;
				else ns = WAIT;
			end // WAIT
			
			RELEASING_TO_CHEAT: begin
				if(!playing || collision) ns = WAIT;
				else if(out0 && out1 && out2 && out3 && out4) ns = RELEASING_TO_CHEAT;
				else ns = CHEATING;
			end // RELEASING_TO_CHEAT
			
			CHEATING: begin
				if(!playing || collision) ns = WAIT;
				else if(out0 && out1 && out2 && out3 && out4) ns = RELEASING_TO_WAIT;
				else ns = CHEATING;
			end // CHEATING
			
			RELEASING_TO_WAIT: begin
				if(!playing || collision) ns = WAIT;
				else if(out0 && out1 && out2 && out3 && out4) ns = RELEASING_TO_WAIT;
				else ns = WAIT;
			end // RELEASING_TO_WAIT
			
			default: begin
				ns = WAIT;
			end // default
		endcase  // case(ps)
	end
	
	assign out = (ps == CHEATING);
	
endmodule // cheat_check

/* testbench for cheat_check */
module cheat_check_testbench();
	logic clk, reset, playing, collision;
	logic [7:0] outCode;
	logic makeBreak, valid;
	logic out;
	parameter L0 = 8'h00;
	parameter L1 = 8'h11;
	parameter L2 = 8'h22;
	parameter L3 = 8'h33;
   parameter L4 = 8'h44;
	
	cheat_check #(.L0(L0), .L1(L1), .L2(L2), .L3(L3), .L4(L4)) dut (.*);
	
	// provide clock
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
		// reset the system to a known state
		reset <= 1'b1;
		playing <= 1'b0;
		collision <= 1'b0;
		makeBreak <= 1'b0;
		valid <= 1'b0;
		outCode <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// if on menu, cheat codes should be ignored
		outCode <= L0;
		valid <= 1'b1;
		makeBreak <= 1'b1;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		
		// if playing, cheat code entry should succeed
		playing <= 1'b1;
		outCode <= L0;
		valid <= 1'b1;
		makeBreak <= 1'b1;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		
		repeat (5) @(posedge clk);
		
		// now de-activate the cheat
		outCode <= L0;
		valid <= 1'b1;
		makeBreak <= 1'b1;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		
		// now activate the cheat once again
		collision <= 1'b0;
		outCode <= L0;
		valid <= 1'b1;
		makeBreak <= 1'b1;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		
		// if player has lost, cheat code activation/de-activation ignored
		collision <= 1'b1;
		outCode <= L0;
		valid <= 1'b1;
		makeBreak <= 1'b1;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		makeBreak <= 1'b0;
		@(posedge clk);
		outCode <= L1;
		@(posedge clk);
		outCode <= L2;
		@(posedge clk);
		outCode <= L3;
		@(posedge clk);
		outCode <= L4;
		@(posedge clk);
		
		// Now, the game is re-started and the cheat is disabled automatically
		collision <= 1'b0;
		playing <= 1'b0;
		@(posedge clk);
		playing <= 1'b1;
		@(posedge clk);
		@(posedge clk);
		
		$stop;
		
	end // initial
endmodule // cheat_check_testbench