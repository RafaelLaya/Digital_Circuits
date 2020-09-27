// Simple DFF with an enable signal
// en: Enables the DFF if True
// in: input data
// out: output data
// in transfers to out in the next cycle if en is enabled, otherwise out holds its value
module DEN_FF(clk, reset, en, in, out);
	input logic clk, reset, en, in;
	output logic out;
	
	always_ff @(posedge clk) begin
		if(reset) out <= 1'b0;
		else if(en) out <= in;
		else out <= out;
	end
endmodule


module DEN_FF_testbench();
	logic clk, reset, en, in;
	logic out;
	
	DEN_FF dut (.clk, .reset, .en, .in, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		in <= 0;
		en <= 0;
		@(posedge clk);
		reset <= 0;
		
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		
		in <= 0;
		en <= 1;
		for(integer i = 0; i < 10; i++) begin
			in <= ~in;
			@(posedge clk);
		end
		
		$stop;
	end
endmodule