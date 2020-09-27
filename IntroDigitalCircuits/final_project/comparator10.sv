// out: TRUE if A > B, otherwise FALSE
// Performs 10-bit unsigned integer comparison
module comparator10(out, A, B);
	input logic [9:0] A, B;
	output logic out;
	
	// logic is unsigned by default
	assign out = (A > B);
	
endmodule