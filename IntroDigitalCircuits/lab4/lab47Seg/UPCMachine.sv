// Checks whether the item has been discounted and/or stolen based on
// the 3-bits UPC code and a secret mark
// discounted == 1 when the item has been on discount, otherwise 0
// stolen == 1 when the item is suspected to have been stolen, otherwise 0
module UPCMachine(stolen, discounted, UPC, mark);
	input logic [2:0] UPC;
	input logic mark;
	output logic stolen, discounted;
	logic notCNorU;
	
	assign discounted = UPC[1] | (UPC[2] & UPC[0]);
	
	nor n1(notCNorU, ~UPC[0], UPC[2]);
	nor n2(stolen, notCNorU, mark, UPC[1]);
endmodule

module UPCMachine_testbench();
	logic [2:0] UPC;
	logic mark;
	logic stolen, discounted;
	
	UPCMachine dut (.stolen, .discounted, .UPC, .mark);
	
	initial begin
		integer i;
		for(i = 0; i < 16; i++) begin
			{mark, UPC} = i;
			#10;
		end
	end
endmodule