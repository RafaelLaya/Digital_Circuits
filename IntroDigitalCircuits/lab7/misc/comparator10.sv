// out: TRUE if A > B, otherwise FALSE
// Performs 10-bit unsigned integer comparison
module comparator10(out, A, B);
	input logic [9:0] A, B;
	output logic out;
	
	// logic is unsigned by default
	assign out = (A > B);
	
endmodule

module comparator10_testbench();
	logic [9:0] A, B;
	logic out;
	
	comparator10 dut (.out, .A, .B);
	
	initial begin
		for(integer i = 0; i < 1024; i++) begin
			A = i;
			for(integer j = 0; j < 1024; j++) begin
				B = j;
				#10;
			end
		end
	end
endmodule