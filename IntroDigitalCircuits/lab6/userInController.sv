// out: true if in has been through a transition low-> high
module userInController(in, out, reset, clk);
	input logic in, reset, clk;
	output logic out;
	
	parameter logic prevWasFalse = 0, prevWasTrue = 1;
	logic ps, ns;
	
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
	
	always_ff @(posedge clk) begin
		if(reset) ps <= prevWasFalse;
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
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;				@(posedge clk);
		in <= 0;				@(posedge clk);
		in <= 1;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		$stop;
	end
endmodule