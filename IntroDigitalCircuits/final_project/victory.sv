// win1: TRUE when player with ID1 (left player) has won one game within a match of tug of war
//			i.e.: left-most light is on and left player presses its button but right doesn't
// win2: TRUE when player with ID2 (right player) has won one game within a match of tug of war
//			i.e.: right-most light is on and right player presses its button but left doesn't
module victory(leftMostOn, rightMostOn, rightButtonPressed, leftButtonPressed, win1, win0, clk, reset);
	input logic leftMostOn, rightMostOn, rightButtonPressed, leftButtonPressed, clk, reset;
	output logic win1, win0;
	
	parameter logic [1:0] noWinnerYet = 2'b00, leftPlayerWon = 2'b10, rightPlayerWon = 2'b01;
	logic [1:0] ps, ns;
	
	always_comb begin
		case(ps) 
			noWinnerYet: begin
				if(rightMostOn && rightButtonPressed && ~leftButtonPressed) ns = rightPlayerWon;
				else if(leftMostOn && leftButtonPressed && ~rightButtonPressed) ns = leftPlayerWon;
				else ns = noWinnerYet;
			end
						
			leftPlayerWon: begin
				ns = noWinnerYet;
			end
			
			rightPlayerWon: begin
				ns = noWinnerYet;
			end
			
			default: begin
				ns = 2'bxx;
			end
		endcase
	end
	
	always_comb begin
		case(ps) 
			noWinnerYet: begin
				win1 = 1'b0;
				win0 = 1'b0;
			end
			
			leftPlayerWon: begin
				win1 = 1'b1;
				win0 = 1'b0;
			end
			
			rightPlayerWon: begin
				win1 = 1'b0;
				win0 = 1'b1;
			end
			
			default: begin
				win1 = 1'bx;
				win0 = 1'bx;
			end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset) ps <= noWinnerYet;
		else ps <= ns;
	end
	
endmodule

module victory_testbench();
	logic leftMostOn, rightMostOn, rightButtonPressed, leftButtonPressed, clk, reset;
	logic win0, win1;
	
	victory dut(.leftMostOn, .rightMostOn, .rightButtonPressed, .leftButtonPressed, .clk, .reset, .win0, .win1);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		leftMostOn <= 0;
		rightMostOn <= 0;
		rightButtonPressed <= 0;
		leftButtonPressed <= 0;
		
											@(posedge clk);
		reset <= 0;						@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
		leftButtonPressed <= 1;	@(posedge clk);
		rightButtonPressed <= 0;		@(posedge clk);
		leftButtonPressed <= 0;	@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
											@(posedge clk);
		leftButtonPressed <= 1;	@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 0;		@(posedge clk);
											@(posedge clk);
		leftButtonPressed <= 0;	@(posedge clk);
											@(posedge clk);
		
		leftMostOn <= 1;				@(posedge clk);
		leftButtonPressed <= 1;	@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 0;
		leftButtonPressed <= 0;
		leftMostOn <= 0;
		rightMostOn <= 1;
											@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
											@(posedge clk);
		leftButtonPressed <= 1;	@(posedge clk);
											@(posedge clk);
		rightButtonPressed <= 0;		@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		reset <= 1;						@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		reset <= 0;
		leftMostOn <= 1;				@(posedge clk);
		leftButtonPressed <= 1;	@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
		leftButtonPressed <= 0;	@(posedge clk);
											@(posedge clk);
		
		$stop;
	end
	
endmodule
