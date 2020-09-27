// Based on the inputs in1 and in0, the leds will flash in patterns at the speed of the clock
//	in1	in0	Pattern
//	0		0		Calm: 101 -> 010
//	0		1		Right to Left: 001 -> 010 -> 100
// 1		0		Left to Right: 100 -> 010 -> 001
module windMachine(in1, in0, leds, clk, reset);
	input logic in1, in0, clk, reset;
	output logic [2:0] leds;
	
	parameter [1:0] outside = 2'b11, center = 2'b00, left = 2'b10, right = 2'b01;
	logic [1:0] ns, ps;
		
	always_comb begin
			case(ps) 
			left: begin
				if(in1 & ~in0) ns = center;
				else if(~in1 & in0) ns = right;
				else if(~in1 & ~in0) ns = outside;
				else ns = 2'bX;
			end
			center: begin
				if(in1 & ~in0) ns = right;
				else if(~in1 & in0) ns = left;
				else if(~in1 & ~in0) ns = outside;
				else ns = 2'bX;
			end
			right: begin
				if(in1 & ~in0) ns = left;
				else if(~in1 & in0) ns = center;
				else if(~in1 & ~in0) ns = outside;
				else ns = 2'bX;
			end
			outside: begin
				if(in1 & ~in0) ns = left;
				else if(~in1 & in0) ns = right;
				else if(~in1 & ~in0) ns = center;
				else ns = 2'bX;
			end
			default: begin
				ns = 2'bX;
			end
		endcase
	end
		
	always_comb begin
		case(ps)
			left: leds = 3'b100;
			right: leds = 3'b001;
			center: leds = 3'b010;
			outside: leds = 3'b101;
			default: leds = 3'bX;
		endcase
	end

	always_ff @(posedge clk) begin
		if(reset) 
			ps <= outside;
		else
			ps <= ns;
	end
endmodule

module windMachine_testbench();
	logic in1, in0, reset;
	logic [2:0] leds;
	logic clk;
	parameter CLK_PERIOD = 100;
	
	windMachine dut(.in1, .in0, .leds, .clk, .reset);
	
	initial begin
		clk = 0;
		forever begin
		#(CLK_PERIOD / 2);
		clk <= ~clk;
		end
	end
	
	
	initial begin
		reset <= 1; 
		// in == 00
		in1 <= 0;
		in0 <= 0;	@(posedge clk);
		reset <= 0;	@(posedge clk);
		
		
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
		// in == 10
		in1 <= 1;	@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
		// in == 01
		in1 <= 0;
		in0 <= 1;
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
		in1 <= 0;
		in0 <= 0;
						@(posedge clk);
		in1 <= 1;   @(posedge clk);
		in1 <= 0;
		in0 <= 1;   @(posedge clk);
						@(posedge clk);
		// in == 11 (don't care) 
		in0 <= 1;
		in1 <= 1;
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
		$stop;
	end
endmodule