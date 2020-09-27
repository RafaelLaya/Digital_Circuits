/* divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... 
  [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ... */
// Provided by LEDDriver
// Added a reset only for testbench purposes 
module clock_divider (clock, divided_clocks, reset);
 input logic clock, reset;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
	if(reset) divided_clocks <= 32'b0;
	else divided_clocks <= divided_clocks + 1;
 end
endmodule 

module clock_divider_testbench();
	logic clock;
	logic [31:0] divided_clocks;
	logic reset;
	
	clock_divider dut (.clock, .divided_clocks, .reset);
	
	parameter CLOCK_PERIOD = 10;
	
	initial begin
		clock <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clock <= ~clock;
		end
	end
	
	initial begin
		reset <= 1;
		@(posedge clock);
		reset <= 0;
		for(integer i = 0; i < 3200; i++) begin
			@(posedge clock);
		end
		$stop;
	end
endmodule