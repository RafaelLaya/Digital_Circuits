module inFilter(clk, reset, d1, d2, d3, q1, q2, q3);
	input logic clk, reset;
	input logic d1, d2, d3;
	output logic q1, q2, q3;
	
	logic d1_F1, d2_F2, d3_F3;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			q1 <= 0;
			q2 <= 0;
			q3 <= 0;
			d1_F1 <= 0;
			d2_F2 <= 0;
			d3_F3 <= 0;
		end
		else begin
			d1_F1 <= d1;
			d2_F2 <= d2;
			d3_F3 <= d3;
			q1 <= d1_F1;
			q2 <= d2_F2;
			q3 <= d3_F3;
		end
	end
endmodule