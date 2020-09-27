// out: immediately true during one clock cycle if in has been through a transition low->high
module userInController(in, out, reset, clk);
	input logic in, reset, clk;
	output logic out;
	
	// remembers previous state, so that it can detect a transition
	parameter logic prevWasFalse = 0, prevWasTrue = 1;
	logic ps, ns;
	
	// next-state logic
	always_comb begin
		case(ps)
			prevWasFalse: begin
				if(in) ns = prevWasTrue;
				else ns = prevWasFalse;
			end
			prevWasTrue: begin
				if(in) ns = prevWasTrue;
				else ns = prevWasFalse;
			end
			default: begin
				ns = 1'bx;
			end
		endcase
	end
	
	// output logic
	always_comb begin
		case(ps)
			prevWasFalse: begin
				if(in) out = 1'b1;
				else out = 1'b0;
			end
			prevWasTrue: begin
				if(in) out = 1'b0;
				else out = 1'b0;
			end
			default: begin
				out = 1'bx;
			end
		endcase
	end
	
	// D Flip Flop. D=ns, Q=ps
	always_ff @(posedge clk) begin
		if(reset) ps <= prevWasTrue;
		else ps <= ns;
	end
endmodule

module userInController_testbench();
	logic in, reset, clk;
	logic out;
	
	userInController dut(.in, .reset, .clk, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end	
	
	initial begin
		in <= 0;
		reset <= 1;			@(posedge clk);
		reset <= 0;
		
		// user doesn't press button
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								
		// user holds button
		in <= 1;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		// some low->high transitions
		in <= 1;				@(posedge clk);
		in <= 0;				@(posedge clk);
		in <= 1;				@(posedge clk);
		in <= 0;				@(posedge clk);
		in <= 1;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		$stop;
	end
endmodule