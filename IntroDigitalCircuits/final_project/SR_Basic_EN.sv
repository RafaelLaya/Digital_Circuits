// Basic 16-bit Shift Register that gets activated if en is TRUE composed of DFFs
module SR_Basic_EN(clk, reset, in, out, en);
	input logic clk, reset, in, en;
	output logic [15:0] out;
	 
	DEN_FF D00 (.clk(clk), .reset(reset), .en(en), .in(in), 			.out(out[00]));
	DEN_FF D01 (.clk(clk), .reset(reset), .en(en), .in(out[00]), 	.out(out[01]));
	DEN_FF D02 (.clk(clk), .reset(reset), .en(en), .in(out[01]), 	.out(out[02]));
	DEN_FF D03 (.clk(clk), .reset(reset), .en(en), .in(out[02]), 	.out(out[03]));
	DEN_FF D04 (.clk(clk), .reset(reset), .en(en), .in(out[03]), 	.out(out[04]));
	DEN_FF D05 (.clk(clk), .reset(reset), .en(en), .in(out[04]), 	.out(out[05]));
	DEN_FF D06 (.clk(clk), .reset(reset), .en(en), .in(out[05]), 	.out(out[06]));
	DEN_FF D07 (.clk(clk), .reset(reset), .en(en), .in(out[06]), 	.out(out[07]));
	DEN_FF D08 (.clk(clk), .reset(reset), .en(en), .in(out[07]), 	.out(out[08]));
	DEN_FF D09 (.clk(clk), .reset(reset), .en(en), .in(out[08]), 	.out(out[09]));
	DEN_FF D10 (.clk(clk), .reset(reset), .en(en), .in(out[09]), 	.out(out[10]));
	DEN_FF D11 (.clk(clk), .reset(reset), .en(en), .in(out[10]), 	.out(out[11]));
	DEN_FF D12 (.clk(clk), .reset(reset), .en(en), .in(out[11]), 	.out(out[12]));
	DEN_FF D13 (.clk(clk), .reset(reset), .en(en), .in(out[12]), 	.out(out[13]));
	DEN_FF D14 (.clk(clk), .reset(reset), .en(en), .in(out[13]), 	.out(out[14]));
	DEN_FF D15 (.clk(clk), .reset(reset), .en(en), .in(out[14]), 	.out(out[15]));
endmodule

module SR_Basic_EN_testbench();
	logic clk, reset, in, en;
	logic [15:0] out;
	
	SR_Basic_EN dut (.clk, .reset, .in, .en, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		en <= 0;
		in <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		
		// Tests enable FALSE
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		in <= 0;
		
		// tests enable TRUE
		en <= 1;
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		
		// tests enable FALSE after it has been shifting for a while
		en <= 0;
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		in <= 0;
		
		// tests enable TRUE after it has been FALSE for a while
		// also correct shifting after the SR has been filled
		en <= 1;
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		
		$stop;
	end
	
endmodule