// Creates a pipe in the flappy-bird game
// A pipe is created by holding ledsFirstCol for the period of one MOVE signal
// (this duration must be synchronized with the MOVE signal)

// The pipe is created when it receives a TRUE move signal for 'HORIZONTAL_SPACING' times
// The pipe is created at a random height based on a 10-bit LSFR
// The horizontal-spacing between two pipes shrinks as score grows
// The vertical-spacing (the whole for the bird to go through) shrinks as score grows
// ledsFirstCol contains the pipe 
module PipeFactory(reset, clk, move, ledsFirstCol, score);
	input logic reset, clk, move;
	input logic [19:0] score;
	output logic [15:0] ledsFirstCol;
	
	// x_reg is used to remember the value of x when MOVE occurs
	// This is used so that ledsFirstCol can be held with a stable value when creating a new pipe
	logic [3:0] x_reg;
	logic [3:0] x;
	logic [4:0] cntr; 
	
	logic [2:0] SPACING;
	logic [4:0] HORIZONTAL_SPACING;
	
	// states
	parameter logic BLANK = 1'b0, SEND_PIPE = 1'b1;
	logic ps, ns;
	
	// vertical spacing logic
	always_comb begin
		if(score < 5) SPACING = 5;
		else if(score < 10) SPACING = 4;
		else if(score < 100) SPACING = 3;
		else SPACING = 2;
	end
	
	// horizontal spacing logic
	always_comb begin
		if			(score < 001) 	HORIZONTAL_SPACING = 16;
		else if	(score < 002) 	HORIZONTAL_SPACING = 15;
		else if	(score < 003) 	HORIZONTAL_SPACING = 14;
		else if	(score < 005) 	HORIZONTAL_SPACING = 13;
		else if	(score < 010) 	HORIZONTAL_SPACING = 12;
		else if	(score < 015) 	HORIZONTAL_SPACING = 11; 
		else if	(score < 020) 	HORIZONTAL_SPACING = 10;
		else if	(score < 050) 	HORIZONTAL_SPACING = 09;
		else if	(score < 100) 	HORIZONTAL_SPACING = 08; 
		// as vertical spacing shrinks, horizontal space
		// must decrease to keep game non-impossible
		else 							HORIZONTAL_SPACING = 11;
	end
	
	// pipe creation logic. x determines where the whole of the pipe will be
	always_comb begin
		if(ps == BLANK) ledsFirstCol = 16'b0000000000000000;
		else begin
			for(integer i = 0; i < 16; i++) begin
				if(x_reg <= i && i <= (x_reg + SPACING - 1)) ledsFirstCol[i] = 1'b0;
				else ledsFirstCol[i] = 1'b1;
			end
		end
	end
	
	// x_reg logic (remembers x)
	always_ff @(posedge clk) begin
		if(reset) x_reg <= 4'b0000;
		else if(move) x_reg <= x;
		else x_reg <= x_reg;
	end
	
	// x logic (calculates x pseudo-randomly). x determines where the pipe's hole will be
	logic [9:0] randomX;
	lsfr10 randomizer (.Q(randomX), .clk, .reset(1'b0));
	always_comb begin
		if		 (randomX < 068)  x = 4'b0001;
		else if(randomX < 137) 	x = 4'b0010;
		else if(randomX < 206) 	x = 4'b0011;
		else if(randomX < 275)  x = 4'b0100;
		else if(randomX < 344) 	x = 4'b0101;
		else if(randomX < 413) 	x = 4'b0110;
		else if(randomX < 482) 	x = 4'b0111;
		else if(randomX < 551) 	x = 4'b1000;
		else if(randomX < 620)  x = 4'b1001;
		else if(randomX < 689)  x = 4'b1010;
		else if(randomX < 758)  x = (4'b1111 - 4'(SPACING) - 4'b0000);
		else if(randomX < 827)  x = (4'b1111 - 4'(SPACING) - 4'b0001);
		else if(randomX < 896)  x = (4'b1111 - 4'(SPACING) - 4'b0010);
		else if(randomX < 965)  x = (4'b1111 - 4'(SPACING) - 4'b0011);
		else 							x = (4'b1111 - 4'(SPACING) - 4'b0100);
	end	
	
	// cntr logic: How many times the MOVE signal has been detected to be TRUE
	always_ff @(posedge clk) begin
		if(reset) cntr <= (HORIZONTAL_SPACING - SPACING);
		else if((ps == SEND_PIPE) && move) cntr <= 4'b0000;
		else if(move) cntr <= (cntr + 4'b0001);
		else cntr <= cntr; 
	end
	
	// state logic: BLANK is no pipe, SEND_PIPE creates a pipe
	always_comb begin
		case(ps) 
		BLANK: begin
			if(move && (cntr >= (HORIZONTAL_SPACING - 1))) ns = SEND_PIPE;
			else ns = BLANK;
		end
		SEND_PIPE: begin
			if(move) ns = BLANK;
			else ns = SEND_PIPE;
		end
		endcase
		
	end
	
	// state transition
	always_ff @(posedge clk) begin
		if(reset) ps <= BLANK;
		else ps <= ns;
	end
	
endmodule

module PipeFactory_testbench();
	logic reset, clk, move;
	logic [15:0] ledsFirstCol;
	
	PipeFactory dut (.reset, .clk, .move, .ledsFirstCol);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		move <= 1'b0;
		reset <= 1'b1;				@(posedge clk);
		reset <= 1'b0;				@(posedge clk);
		
		for(integer j = 0; j < 20; j++) begin
			// tests pipe creation
			move <= 1'b1;
			for(integer i = 0; i < 10; i++) begin
				@(posedge clk);
			end
			move <= 1'b0;
			// tests BLANK
			for(integer i = 0; i < 10; i++) begin
				@(posedge clk);
			end
			move <= 1'b1;
			@(posedge clk);
			move <= 1'b0;
		end
		$stop;
	end
	
endmodule