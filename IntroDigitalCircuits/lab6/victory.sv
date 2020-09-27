// gameFinished: if the leftmost LED is ON and the right player advances, gameFinished is true
//					  if the rightmost LED is ON and the left player advances, gameFinished is true
//	winnerId: 1 for right player, 0 for left player
module victory(leftMostOn, rightMostOn, rightButtonPressed, leftButtonPressed, gameFinished, winnerId, clk, reset);
	input logic leftMostOn, rightMostOn, rightButtonPressed, leftButtonPressed, clk, reset;
	output logic gameFinished, winnerId;
	
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
				gameFinished = 0;
				winnerId = 1'bx;
			end
			
			leftPlayerWon: begin
				gameFinished = 1;
				winnerId = 1;
			end
			
			rightPlayerWon: begin
				gameFinished = 1;
				winnerId = 0;
			end
			
			default: begin
				gameFinished = 1'bx;
				winnerId = 1'bx;
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
	logic gameFinished, winnerId;
	
	victory dut(.leftMostOn, .rightMostOn, .rightButtonPressed, .leftButtonPressed, .clk, .reset, .gameFinished, .winnerId);
	
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
