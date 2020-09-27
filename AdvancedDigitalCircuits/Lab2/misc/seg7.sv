/* Converts a bcd number into a format by the 7 Segment
 * displays of the DE1_soC board
 * 
 * Inputs:
 *   bcd   - A 4-bit number in hex format (0-9, A, b, C, d, E, F)
 *
 * Outputs:
 *   leds  - A 7-bit output that can be connected to a HEX display in the DE1_SoC board
 *  
 * Usually connected to a HEX display, or to a MUX that outputs
 * to a HEX display
*/
module seg7 (bcd, leds); 
	input logic [3:0] bcd;
	output logic [6:0] leds;

	always_comb begin
		case (bcd)
		4'b0000: leds = ~7'b0111111; // 0
	   4'b0001: leds = ~7'b0000110; // 1
	   4'b0010: leds = ~7'b1011011; // 2
	   4'b0011: leds = ~7'b1001111; // 3
	   4'b0100: leds = ~7'b1100110; // 4
	   4'b0101: leds = ~7'b1101101; // 5
	   4'b0110: leds = ~7'b1111101; // 6
	   4'b0111: leds = ~7'b0000111; // 7
	   4'b1000: leds = ~7'b1111111; // 8
	   4'b1001: leds = ~7'b1101111; // 9
		4'b1010: leds = ~7'b1110111; // A
		4'b1011: leds = ~7'b1111100; // b
		4'b1100: leds = ~7'b0111001; // C
		4'b1101: leds = ~7'b1011110; // d
		4'b1110: leds = ~7'b1111001; // E
		4'b1111: leds = ~7'b1110001; // F
	   default: leds =  7'bXXXXXXX;
		endcase // case(bcd)
	end // always_comb
	
endmodule  // seg7

/* testbench for seg7 */
module seg7_testbench();
	logic [3:0] bcd;
	logic [6:0] leds;
	parameter WAIT_TIME = 100;
	
	seg7 dut(.bcd, .leds);
	
	initial begin
		integer i;
		// go through all valid combinations
		for(i = 0; i < 2 ** 4; i++) begin
			bcd = i;
			#(WAIT_TIME);
		end // for
	end // initial
	
endmodule // seg7_testbench