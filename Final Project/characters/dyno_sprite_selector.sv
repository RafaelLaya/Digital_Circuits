/* Selects the sprite for dyno, based on its status (jumping, running, ducking) and whether animations are enabled
 *
 * Inputs:
 *   	clk						- Clock signal
 *		reset						- active-high reset signal
 *		collision				- active-high signal indicates there has been a collision
 *		move						- active-high signal that synchronizes game elements
 *		dyno_up					- active-high signal indicates dyno is standing up
 *		dyno_flying				- active-high signal indicates dyno is flying
 *		anim						- active-high signal indicates animations are activated
 *		
 *
 * Outputs:
 *   	dyno_current_sprite	- selected sprite for dyno
 */
module dyno_sprite_selector(reset, clk, dyno_current_sprite, move, collision, dyno_up, dyno_flying, anim);
	input logic reset, clk, move, collision, dyno_up, dyno_flying, anim;
	output logic [31:0][23:0] dyno_current_sprite [0:31];
	
	// load sprites from memory
	logic [31:0][23:0] dyno_running_sprite0 [0:31];
	logic [31:0][23:0] dyno_running_sprite1 [0:31];
	logic [31:0][23:0] dyno_flying_sprite   [0:31];
	logic [31:0][23:0] dyno_ducking0_sprite [0:31];
	logic [31:0][23:0] dyno_ducking1_sprite [0:31];
	ROM_dyno_running_sprite0 sprite0_mem (.dyno_running_sprite0);
	ROM_dyno_running_sprite1 sprite1_mem (.dyno_running_sprite1);
	ROM_dyno_flying_sprite sprite_flying_mem (.dyno_flying_sprite);
	ROM_dyno_ducking0_sprite sprite_ducking0_mem (.dyno_ducking0_sprite);
	ROM_dyno_ducking1_sprite sprite_ducking1_mem (.dyno_ducking1_sprite);
	
	// slow down sprite-switching with a predivisor
	logic [7:0] prediv;
	always_ff @(posedge clk) begin
		if(reset) prediv <= 0;
		else if(move && prediv > 10) prediv <= 0;
		else if(move) prediv <= prediv + 1;
	end // always_ff
	
	// switch based on predivisor
	logic switch;
	always_ff @(posedge clk) begin
		if(reset) switch <= 0;
		else if(move && prediv > 10) switch <= 1;
		else switch <= 0;
	end // always_ff
	
	// possible states
	enum {RUNNING0, RUNNING1, FLYING, DUCKING0, DUCKING1} sprite_sel;
	
	// make the sprite switches
	always_ff @(posedge clk) begin
		if(reset) sprite_sel <= RUNNING0;
		else if(collision) sprite_sel <= sprite_sel;
		else if(switch && dyno_up && !dyno_flying) begin
			if(!anim) sprite_sel <= FLYING;
			else if(sprite_sel == RUNNING1) sprite_sel <= RUNNING0;
			else sprite_sel <= RUNNING1;
		end // else if(move && dyno_up && !dyno_flying)
		else if(switch && !dyno_up) begin
			if(sprite_sel == DUCKING0 && !dyno_flying || !anim) sprite_sel <= DUCKING1;
			else if(sprite_sel == DUCKING1 && !dyno_flying) sprite_sel <= DUCKING0;
			else sprite_sel <= DUCKING1;
		end // else if(move && !(dyno_up)
		else if(switch && dyno_flying) sprite_sel <= FLYING;
		else sprite_sel <= sprite_sel;
	end // always_ff
	
	always_comb begin
		case(sprite_sel) 
			RUNNING0: dyno_current_sprite = dyno_running_sprite0;
			RUNNING1: dyno_current_sprite = dyno_running_sprite1;
			FLYING: dyno_current_sprite = dyno_flying_sprite;
			DUCKING0: dyno_current_sprite = dyno_ducking0_sprite;
			DUCKING1: dyno_current_sprite = dyno_ducking1_sprite;
			default: dyno_current_sprite = dyno_running_sprite0;
		endcase // case(sprite_sel)
	end // always_comb

endmodule // dyno_sprite_selector

/* testbench for dyno_sprite_selector */
module dyno_sprite_selector_testbench();
	logic reset, clk, move, collision, dyno_up, dyno_flying, anim;
	logic [31:0][23:0] dyno_current_sprite [0:31];
	
	dyno_sprite_selector dut (.*);
	
	// simulate clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		move <= 1'b1;
		collision <= 1'b0;
		dyno_up <= 1'b1;
		dyno_flying <= 1'b0;
		anim <= 1'b0;
		@(posedge clk);
		reset <= 1'b0;
		move <= 1'b1;
		
		// animations disabled
		anim <= 1'b0;
		repeat (50) @(posedge clk);
		
		// enable animations
		// walking
		anim <= 1'b1;
		repeat (50) @(posedge clk);
		
		// flying
		dyno_flying <= 1'b1;
		repeat (50) @(posedge clk);
		
		// flying and ducking
		dyno_up <= 1'b0;
		dyno_flying <= 1'b1;
		repeat (50) @(posedge clk);
		
		// ducking
		dyno_flying <= 1'b0;
		repeat (50) @(posedge clk);
		
		// stop moving
		move <= 1'b0;
		repeat (50) @(posedge clk);
		
		// move but collision occurred
		move <= 1'b1;
		collision <= 1'b1;
		repeat (50) @(posedge clk);
		
		$stop;
		
	end // initial
	
endmodule // dyno_sprite_selector_testbench
	