// Tug of War
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	// Set Hex Display Off since these won't be used. 
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// LEDR[0] is out of bounds from the battlefield. 
	assign LEDR[0] = 1'b0;
 
	// filter input through DFFs
	logic KEY3_F, KEY0_F;
	logic leftButton, rightButton, reset;
	
	D_FF KEY0_FILTER1 (.clk(CLOCK_50), .reset(SW[9]), .d(KEY[0]), .q(KEY0_F));
	D_FF KEY3_FILTER1 (.clk(CLOCK_50), .reset(SW[9]), .d(KEY[3]), .q(KEY3_F));
	
	D_FF KEY0_FILTER2 (.clk(CLOCK_50), .reset(SW[9]), .d(KEY0_F), .q(rightButton));
	D_FF KEY3_FILTER2 (.clk(CLOCK_50), .reset(SW[9]), .d(KEY3_F), .q(leftButton));
	
	// connect the machines
	logic rightPressed, leftPressed;
	
	// Detect rising edges in the filtered inputs
	userInController rightButtonController (.clk(CLOCK_50), .reset(SW[9]), .in(~rightButton), .out(rightPressed));
	userInController leftButtonController (.clk(CLOCK_50), .reset(SW[9]), .in(~leftButton) , .out(leftPressed));
	
	// Connect the battlefieldLights. LEDR[5] is initially ON, others are initially OFF. 
	battlefieldLight light1 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[1]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(1'b0), .neighborLeft(LEDR[2]));
						  
	battlefieldLight light2 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[2]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[1]), 
						  .neighborLeft(LEDR[3]));
						  
	battlefieldLight light3 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[3]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[2]), 
						  .neighborLeft(LEDR[4]));
	
	battlefieldLight light4 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[4]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[3]), 
						  .neighborLeft(LEDR[5]));
						  
	battlefieldLight light5 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[5]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b1), .neighborRight(LEDR[4]), 
						  .neighborLeft(LEDR[6]));
	
	battlefieldLight light6 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[6]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[5]), 
						  .neighborLeft(LEDR[7]));
						  
	battlefieldLight light7 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[7]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[6]), 
						  .neighborLeft(LEDR[8]));
						  
	battlefieldLight light8 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[8]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[7]), 
						  .neighborLeft(LEDR[9]));
						  
	battlefieldLight light9 (.reset(SW[9]), .clk(CLOCK_50), .lightOn(LEDR[9]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[8]), 
						  .neighborLeft(1'b0));
	

	logic gameFinished;
	logic winnerID;
	
	// Check whether the game has finihed
	victory winnerChecker (.clk(CLOCK_50), .reset(SW[9]), .rightMostOn(LEDR[1]), .leftMostOn(LEDR[9]), .leftButtonPressed(leftPressed), 
			  .rightButtonPressed(rightPressed), .gameFinished(gameFinished), .winnerId(winnerID));
	
	// If the game has finished, display the winner
	hexDisplayer winnerDisplay (.winnerID(winnerID), .gameHasFinished(gameFinished), .out(HEX0));
 
endmodule

module DE1_SoC_testbench();
	logic clk;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		SW[9] <= 1;				
		KEY[0] <= 1;
		KEY[3] <= 1;			@(posedge clk);
		SW[9] <= 0;				@(posedge clk);
									@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
									@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
									@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
									@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
									@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;
		KEY[0] <= 1;			@(posedge clk);
		
		KEY[0] <= 0;
		KEY[3] <= 0;			@(posedge clk);
		
		KEY[3] <= 1;
		KEY[0] <= 1;			@(posedge clk);
		
		SW[9] <= 1;				@(posedge clk);
		KEY[3] <= 1;
		KEY[0] <= 1;
									@(posedge clk);
		SW[9] <= 0;				@(posedge clk);
		
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
		KEY[3] <= 1;			@(posedge clk);
		KEY[3] <= 0;			@(posedge clk);
		
		SW[9] <= 1;				@(posedge clk);
		SW[9] <= 0;				@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		$stop;
	end
	
endmodule