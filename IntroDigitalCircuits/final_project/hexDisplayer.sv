// out: HEX (active low) display. If gameHasFinished is false, then displays  nothing
// If gameHasFinished is true:
// Displays '1' if winnerID is 0
// Displays '2' if winnerID is 1
module hexDisplayer(out, winnerID, gameHasFinished);
	input logic winnerID, gameHasFinished;
	output logic [6:0] out; // active low
	
	always_comb begin
		if(gameHasFinished && (winnerID == 0)) out = 7'b1111001;
		else if(gameHasFinished && (winnerID == 1)) out = 7'b0100100;
		else out = 7'b1111111;
	end
endmodule

module hexDisplayer_testbench();
	logic winnerID, gameHasFinished;
	logic [6:0] out; 
	
	hexDisplayer dut(.winnerID, .gameHasFinished, .out);
	
	initial begin
		winnerID = 0;
		gameHasFinished = 0;
		#10;
		winnerID = 1;
		#10;
		gameHasFinished = 1;
		#10;
		winnerID = 0;
		#10;
	end
	
endmodule