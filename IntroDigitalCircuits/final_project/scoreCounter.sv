// Keeps track of the score of a player in tug of war
// out: bcd value of the score between 0 and 7 (both inclusive)
// win: whether this player has just won one game within a match
module scoreCounter(out, win, clk, reset);
	input logic win, clk, reset;
	output logic [3:0] out;
	
	parameter logic [2:0] 	scoreZero = 3'b000, 
									scoreOne = 3'b001, 
									scoreTwo = 3'b010,
									scoreThree = 3'b011,
									scoreFour = 3'b100,
									scoreFive = 3'b101,
									scoreSix = 3'b110,
									scoreSeven = 3'b111;
	logic [2:0] ps, ns;
	
	always_comb begin
		case(ps) 
		
		scoreZero: begin
			if(win) ns = scoreOne;
			else ns = scoreZero;
		end
		
		scoreOne: begin
			if(win) ns = scoreTwo;
			else ns = scoreOne;
		end
		
		scoreTwo: begin
			if(win) ns = scoreThree;
			else ns = scoreTwo;
		end
		
		scoreThree: begin
			if(win) ns = scoreFour;
			else ns = scoreThree;
		end
		
		scoreFour: begin
			if(win) ns = scoreFive;
			else ns = scoreFour;
		end
		
		scoreFive: begin
			if(win) ns = scoreSix;
			else ns = scoreFive;
		end
		
		scoreSix: begin
			if(win) ns = scoreSeven;
			else ns = scoreSix;
		end
		
		scoreSeven: begin
			if(win) ns = 3'bxxx;
			else ns = scoreSeven;
		end
		endcase
	end
	
	always_comb begin
		out = 4'(ps);
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= scoreZero;
		end
		else begin
			ps <= ns;
		end
	end
endmodule

module scoreCounter_testbench();
	logic reset, clk;
	logic win;
	logic [3:0] out;
	
	parameter CLOCK_PERIOD = 100;
	
	scoreCounter dut (.reset, .clk, .win, .out);
	
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		win <= 0;
								@(posedge clk);
		reset <= 0;
								@(posedge clk);
								@(posedge clk);
		win <= 1;			@(posedge clk);
		win <= 0;			@(posedge clk);
								@(posedge clk);
		win <= 1;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		win <= 0;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		win <= 1;			@(posedge clk);
		win <= 0;			@(posedge clk);
		win <= 1;			@(posedge clk);
								@(posedge clk);
		reset <= 1;			@(posedge clk);
		reset <= 0;			@(posedge clk);
		win <= 0;			@(posedge clk);
		
		$stop;
	end
	
endmodule