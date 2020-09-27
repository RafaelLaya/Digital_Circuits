module comparator10(out, A, B);
	input logic [9:0] A, B;
	output logic out;
	
	assign out = (A > B);
	
endmodule