// takes an UPC code and assumes that HEX0, ..., HEX5 correspond to 7-segment active-low displays
// where HEX5 is at the far-most left and HEX0 at the far-most right from the POV of the reader.
// The display is the name of the item based on the UPC code and a small drawing.
module fredmachine(U, P, C, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input logic U, P, C;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	always_comb begin
		case({U, P, C})
			3'b000: begin // Bed
				HEX5 = 7'b0000011;
				HEX4 = 7'b0000110;
				HEX3 = 7'b0100001;
				HEX2 = 7'b1111111;
				HEX1 = 7'b0001111;
				HEX0 = 7'b0111011;
			end
			3'b001: begin // pot
				HEX5 = 7'b0001100;
				HEX4 = 7'b0100011;
				HEX3 = 7'b0000111;
				HEX2 = 7'b1111111;
				HEX1 = 7'b1000111;
				HEX0 = 7'b1110001;
			end
			3'b011: begin // cap
				HEX5 = 7'b1000110;
				HEX4 = 7'b0001000;
				HEX3 = 7'b0001100;
				HEX2 = 7'b1111111;
				HEX1 = 7'b0011100;
				HEX0 = 7'b0111111;
			end
			3'b100: begin // ball
				HEX5 = 7'b0000011;
				HEX4 = 7'b0001000;
				HEX3 = 7'b1001001;
				HEX2 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX0 = 7'b0100011;
			end
			3'b101: begin // rug
				HEX5 = 7'b0101111;
				HEX4 = 7'b1100011;
				HEX3 = 7'b1000010;
				HEX2 = 7'b1111111;
				HEX1 = 7'b1000110;
				HEX0 = 7'b1110000;
			end
			3'b110: begin // pipe
				HEX5 = 7'b0001100;
				HEX4 = 7'b1101111;
				HEX3 = 7'b0001100;
				HEX2 = 7'b0000110;
				HEX1 = 7'b1111111;
				HEX0 = 7'b1001111;
			end
			default: begin
				HEX5 = 7'bX;
				HEX4 = 7'bX;
				HEX3 = 7'bX;
				HEX2 = 7'bX;
				HEX1 = 7'bX;
				HEX0 = 7'bX;
			end
		endcase
	end
endmodule

module fredmachine_testbench();
	logic U, P, C;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	fredmachine dut (.U, .P, .C, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
	initial begin
		for(integer i = 0; i < 8; i++) begin
			{U, P, C} = i;
			#10;
		end
	end
endmodule
	