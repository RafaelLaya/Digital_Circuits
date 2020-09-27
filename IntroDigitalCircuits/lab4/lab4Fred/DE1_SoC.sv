module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Use SW[9:7] as UPC Code and input mark from SW[0]
	// The stolen LED is LEDR[0] and the discounted is LEDR[5]
	// The 6 HEX displays are used for displaying fred's items based on the UPC code
	fredmachine machine(.U(SW[9]), .P(SW[8]), .C(SW[7]), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	UPCMachine itemMarker(.UPC(SW[9:7]), .mark(SW[0]), .stolen(LEDR[0]), .discounted(LEDR[5]));
	
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	initial begin
		integer i;
		for(i = 0; i < 16; i++) begin
			{SW[0], SW[9:7]} = i; 
			#10;
		end
	end
endmodule
