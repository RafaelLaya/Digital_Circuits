// Tug of War: Includes 2-Player and Single-Player Modes. Configurable ONLY at compile-time
//					Uncomment: 'define PLAYER2 1
//								 	to enable player 2 and disable computer-player
//					Comment: 'define PLAYER2 1
//								 to enable computer-player and disable player 2
//
// 				HEX[0] and HEX[5] display the score (0...7) of the players
//					The player controlling KEY[0] has the score shown in HEX[0]
//
//					SW[9] resets the whole system/match/game
//					
//					
//	Single-Player Mode: 	CLOCK-50 is divided to make the computer-player slower
//							  	SW[8:0] Control the computer-player difficulty. Higher SW[:] represents higher difficulty
//								KEY[0] is the user-player control. 
//								Computer-player score is shown in HEX[5]
//
// 2-Player Mode: KEY[0] and KEY[3] are the player controls
//						Score of player controlling KEY[3] is in HEX[5]

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
//  uncomment the following line to disable computer player and enable player 2 controls
//	`define PLAYER2 1

	input logic CLOCK_50; 
	logic tow_clk;
	logic reset;
	
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	
	// Set unused Hex Displays Off 
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	
	// LEDR[0] is out of bounds from the battlefield. 
	assign LEDR[0] = 1'b0;
 	
	
	/******************** clock ********************/
	// If PC player enabled, use a low-speed clock
	`ifndef PLAYER2
	parameter whichClock = 16;
	logic [31:0] divided_clocks;
	clock_divider divider (.clock(CLOCK_50), .divided_clocks, .reset(SW[9]));
	assign tow_clk = divided_clocks[whichClock];
	`endif
	
	// If Player 2 enabled, choose a high-speed clock
	`ifdef PLAYER2
	assign tow_clk = CLOCK_50;
	`endif
	/**********************************************/
	
	/******************** Player Movements ********************/
	
	logic rightPressed, leftPressed;
	
	// If PC player, compute the PC player movements
	`ifndef PLAYER2
	logic [9:0] randomNum;
	logic randomIn;
	lsfr10 randomizer (.Q(randomNum), .reset(SW[9]), .clk(tow_clk));
	comparator10 comp (.out(randomIn), .B(randomNum), .A({1'b0, SW[8:0]}));
	userInController leftButtonController (.clk(tow_clk), .reset(SW[9]), .in(~randomIn) , .out(leftPressed));
	`endif
	
	// If player 2 enabled, Filter KEY[3] 
	`ifdef PLAYER2
	logic KEY3_F, leftButton;
	D_FF KEY3_FILTER1 (.clk(tow_clk), .reset(SW[9]), .d(KEY[3]), .q(KEY3_F));
	D_FF KEY3_FILTER2 (.clk(tow_clk), .reset(SW[9]), .d(KEY3_F), .q(leftButton));
	userInController leftButtonController (.clk(tow_clk), .reset(SW[9]), .in(~leftButton) , .out(leftPressed));
	`endif
	
	// Filter KEY[0]: Player 1 
	logic KEY0_F;
	logic rightButton;
	D_FF KEY0_FILTER1 (.clk(tow_clk), .reset(SW[9]), .d(KEY[0]), .q(KEY0_F));
	D_FF KEY0_FILTER2 (.clk(tow_clk), .reset(SW[9]), .d(KEY0_F), .q(rightButton));
	userInController rightButtonController (.clk(tow_clk), .reset(SW[9]), .in(~rightButton), .out(rightPressed));
	/**********************************************/
	
	
	/******************** Battlefield ********************/
	logic battleFieldReset;
	logic win0, win1;
	
	assign battleFieldReset = SW[9] | win0 | win1;
	
	// Connect the battlefieldLights. LEDR[5] is initially ON, others are initially OFF. 
	battlefieldLight light1 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[1]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(1'b0), .neighborLeft(LEDR[2]));
						  
	battlefieldLight light2 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[2]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[1]), 
						  .neighborLeft(LEDR[3]));
						  
	battlefieldLight light3 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[3]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[2]), 
						  .neighborLeft(LEDR[4]));
	
	battlefieldLight light4 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[4]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[3]), 
						  .neighborLeft(LEDR[5]));
						  
	battlefieldLight light5 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[5]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b1), .neighborRight(LEDR[4]), 
						  .neighborLeft(LEDR[6]));
	
	battlefieldLight light6 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[6]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[5]), 
						  .neighborLeft(LEDR[7]));
						  
	battlefieldLight light7 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[7]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[6]), 
						  .neighborLeft(LEDR[8]));
						  
	battlefieldLight light8 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[8]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[7]), 
						  .neighborLeft(LEDR[9]));
						  
	battlefieldLight light9 (.reset(battleFieldReset), .clk(tow_clk), .lightOn(LEDR[9]), .leftButtonPressed(leftPressed), 
						  .rightButtonPressed(rightPressed), .initialState(1'b0), .neighborRight(LEDR[8]), 
						  .neighborLeft(1'b0));
	
	// Check whether the game has finished
	victory winnerChecker (.clk(tow_clk), .reset(SW[9]), .rightMostOn(LEDR[1]), .leftMostOn(LEDR[9]), .leftButtonPressed(leftPressed), 
			  .rightButtonPressed(rightPressed), .win0(win0), .win1(win1));
	
	// manage/remember/display scores
	logic [3:0] score0, score1;
	scoreCounter counter0 (.clk(tow_clk), .reset(SW[9]), .win(win0), .out(score0));
	scoreCounter counter1 (.clk(tow_clk), .reset(SW[9]), .win(win1), .out(score1));
	
	// If the game has finished, display the winner
	seg7 player0Score (.bcd(score0), .leds(HEX0));
	seg7 player1Score (.bcd(score1), .leds(HEX5));
	/**********************************************/
 
endmodule

// divided_clocks[i] = 25MHz / (2 to the power of (i+1))
module clock_divider (clock, divided_clocks, reset);
	input logic reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
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
		KEY[0] <= 0;
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
		SW[0] <= 1;
									@(posedge clk);
		SW[1] <= 1;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		SW[2] <= 1;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		SW[3] <= 1;
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
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		SW[4] <= 1;
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
		SW[5] <= 1;
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
		KEY[0] <= 1;			@(posedge clk);
		KEY[0] <= 0;			@(posedge clk);
									@(posedge clk);
		SW[6] <= 1;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		SW[7] <= 1;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		SW[8] <= 1;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		
		$stop;
	end
	
endmodule