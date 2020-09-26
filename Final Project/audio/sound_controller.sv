/* Controller for the game-sound
 *
 * Inputs:
 *   	clk						- Clock signal
 *		reset						- active-high reset signal
 *		playing					- active-high signal that represents the game is being played
 *		collision				- active-high signal that represents a collision
 *		next_level				- active-high signal pulse that represents a level transition
 *		jump						- active-high signal that represents a jump
 *		cntr_done				- active-high status signal that represents the current wave of sound should finish
 *		dyno_flying				- active-high signal that represents the main character is in the air
 *
 * Outputs:
 *   	play_X					- active-high control signal that commands datapath to play a wave of X frequency
 */

module sound_controller(clk, reset, playing, collision, next_level, jump, play_300, play_200, play_100, play_400, play_3, cntr_done, dyno_flying, reset_cntr);
	// external signals
	input logic clk, reset;
	input logic playing, collision, jump, next_level, dyno_flying;
	
	// status signals
	input logic cntr_done;
	
	// control signals
	output logic play_3, play_300, play_200, play_100, play_400, reset_cntr;
	
	enum {IDLE, WALKING, LOST0, LOST1, LOST2, LEVELUP0, LEVELUP1, LEVELUP2, JUMP0, JUMP1, JUMP2, FROZEN} ps, ns;
	
	always_ff @(posedge clk) begin
		if(reset || !playing) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	always_comb begin
		case(ps)
			IDLE: begin
				if(playing) ns = WALKING;
				else ns = IDLE;
			end // IDLE
			
			WALKING: begin
				if(!playing) ns = IDLE;
				else if(collision) ns = LOST0;
				else if(next_level) ns = LEVELUP0;
				else if(jump) ns = JUMP0;
				else ns = WALKING;
			end // WALKING
			
			LOST0: begin
				if(cntr_done) ns = LOST1;
				else ns = LOST0;
			end // LOST0
			
			LOST1: begin
				if(cntr_done) ns = LOST2;
				else ns = LOST1;
			end // LOST1
			
			LOST2: begin
				if(cntr_done) ns = FROZEN;
				else ns = LOST2;
			end // LOST2
			
			LEVELUP0: begin
				if(collision) ns = LOST0;
				else if(cntr_done) ns = LEVELUP1;
				else ns = LEVELUP0;
			end // LEVELUP0
			
			LEVELUP1: begin
				if(collision) ns = LOST0;
				else if(cntr_done) ns = LEVELUP2;
				else ns = LEVELUP1;
			end // LEVELUP1
			
			LEVELUP2: begin
				if(collision) ns = LOST0;
				else if(cntr_done) ns = WALKING;
				else ns = LEVELUP2;
			end // LEVELUP2
			
			JUMP0: begin
				if(collision) ns = LOST0;
				else if(next_level) ns = LEVELUP0;
 				else if(!dyno_flying) ns = WALKING;
				else ns = JUMP0;
			end // JUMP0
			
			FROZEN: begin
				if(!playing) ns = IDLE;
				else ns = FROZEN;
			end // FROZEN
			
			default: begin
				ns = IDLE;
			end // default
		
		endcase // case(ps)
	end // always_comb

	// reset_cntr
	always_ff @(posedge clk) begin
		if(reset) reset_cntr <= 1'b0;
		else if(ps != ns) reset_cntr <= 1'b1;
		else reset_cntr <= 1'b0;
	end // always_ff
	
	// play_3
	always_comb begin
		if(ps == WALKING && !dyno_flying) play_3 = 1;
		else play_3 = 0; 
	end // always_comb
	
	// play_300
	always_comb begin
		if(ps == LOST0 || ps == LEVELUP1) play_300 = 1;
		else play_300 = 0;
	end // always_comb
	
	// play_200
	always_comb begin
		if(ps == LEVELUP0 || ps == LOST1) play_200 = 1;
		else play_200 = 0;
	end // always_comb
	
	// play_100
	always_comb begin
		if(ps == LOST2) play_100 = 1;
		else play_100 = 0;
	end // always_comb
	
	// play_400
	always_comb begin
		if(ps == LEVELUP2) play_400 = 1;
		else play_400 = 0;
	end // always_comb
	
endmodule // sound_controller

/* testbench for sound_controller */
module sound_controller_testbench();
	// external signals
	logic clk, reset;
	logic playing, collision, jump, next_level, dyno_flying;
	
	// status signals
	logic cntr_done;
	
	// control signals
	logic play_3, play_300, play_200, play_100, play_400, reset_cntr;
	
	sound_controller dut (.*);
	
	// provide clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		playing <= 1'b0;
		collision <= 1'b0;
		jump <= 1'b0;
		next_level <= 1'b0;
		dyno_flying <= 1'b0;
		cntr_done <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		
		// no sound unless the game is being played
		@(posedge clk);
		next_level <= 1'b1;
		@(posedge clk);
		next_level <= 1'b0; 
		@(posedge clk);
		
		// test footsteps
		playing <= 1'b1;
		repeat (5) begin 
			cntr_done <= 1'b0;
			@(posedge clk);
			cntr_done <= 1'b1;
			@(posedge clk);
			cntr_done <= 1'b0;
		end // repeat(5)
		
		// test collision sound
		collision <= 1'b1;
		repeat (5) begin 
			cntr_done <= 1'b0;
			@(posedge clk);
			cntr_done <= 1'b1;
			@(posedge clk);
			cntr_done <= 1'b0;
		end // repeat(5)
		
		// re-start the game
		collision <= 1'b0;
		playing <= 1'b0;
		@(posedge clk);
		playing <= 1'b1;
		@(posedge clk);
		
		// test no sound on jump
		jump <= 1'b1;
		dyno_flying <= 1'b1;
		@(posedge clk);
		jump <= 1'b0;
		repeat (5) begin 
			cntr_done <= 1'b0;
			@(posedge clk);
			cntr_done <= 1'b1;
			@(posedge clk);
			cntr_done <= 1'b0;
		end // repeat(5)
		dyno_flying <= 1'b0;
		
		// sound on next_level
		@(posedge clk);
		next_level <= 1'b1;
		@(posedge clk);
		next_level <= 1'b0;
		repeat (5) begin 
			next_level <= 1'b0;
			cntr_done <= 1'b0;
			@(posedge clk);
			cntr_done <= 1'b1;
			@(posedge clk);
			cntr_done <= 1'b0;
		end // repeat(5)
		
		@(posedge clk);
		$stop;
		
	end // initial
	
endmodule // sound_controller_testbench