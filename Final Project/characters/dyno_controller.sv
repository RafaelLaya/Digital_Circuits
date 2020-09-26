/* Implements a controller for the main character
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *		collision			- active-high signal indicates a collision occurred
 *		move					- active-high pulses that synchronize the game
 *		playing				- active-high signal that indicates the game is currently being played\
 *		down_pressed		- active-high signal that indicates the user wants dyno to duck
 *		spacebar_pressed	- active-high signal that indicates the user wants dyno to jump
 *		dyno_y				- status signal that indicates the vertical position of dyno
 *
 * Outputs:
 *   	clr_dyno_up			- active-high control signal that tells datapath to CLEAR the standing position of dyno
 *		set_dyno_up			- active-high control signal that tells datapath to SET the standing position of dyno
 *		adv_up				- active-high control signal that tells datapath to set dyno's position higher on the screen
 *		adv_down				- active-high control signal that tells datapath to set dyno's position lower on the screen
 *		init					- active-high control signal that tells datapath to initialize dyno
 *		dyno_flying			- output signal that indicates dyno is in the air
 *		put_dyno_gnd		- active-high control signal that tells datapath to put dyno on ground-level (vertical position)
 *		
 */
module dynosaur_controller(reset, clk, collision, move, playing, clr_dyno_up, set_dyno_up, down_pressed, spacebar_pressed, adv_up, adv_down, init, dyno_y, dyno_flying, put_dyno_gnd);
	// synchronization variables
	input logic reset, clk;
	
	// status signals
	input logic [10:0] dyno_y;
	
	// control signals
	output logic adv_up, adv_down, init, put_dyno_gnd;
	output logic set_dyno_up, clr_dyno_up;
	
	// external signals
	input logic collision, move, playing, down_pressed, spacebar_pressed;
	output logic dyno_flying;
	
	enum {IDLE, GROUND, FROZEN, AIR_UP, AIR_DOWN} ps, ns;
	
	assign dyno_flying = (ps == AIR_UP || ps == AIR_DOWN);
	
	// state transition
	always_ff @(posedge clk) begin
		if(reset) ps <= IDLE;
		else ps <= ns;
	end // always_ff
	
	// next state logic
	always_comb begin
		case(ps)
			IDLE: begin
				if(playing) ns = GROUND;
				else ns = IDLE;
			end // IDLE
			
			GROUND: begin
				if(collision) ns = FROZEN;
				else if(move && spacebar_pressed) ns = AIR_UP;
				else ns = GROUND;
			end // GROUND
			
			FROZEN: begin
				if(playing) ns = FROZEN;
				else ns = IDLE;
			end // FROZEN
			
			AIR_UP: begin
				if(collision) ns = FROZEN;
				else if(move && dyno_y <= 101) ns = AIR_DOWN;
				else ns = AIR_UP;
			end // AIR_UP
			
			AIR_DOWN: begin
				if(collision) ns = FROZEN;
				else if(move && dyno_y >= 202) ns = GROUND;
				else ns = AIR_DOWN;
			end // AIR_DOWN
			
			default: begin
				ns = IDLE;
			end // default
		
		endcase // case(ps)
	end // always_comb
	
	// put_dyno_gnd
	always_ff @(posedge clk) begin
		if(reset) put_dyno_gnd <= 1;
		else if(!playing) put_dyno_gnd <= 1;
		else if(ps == IDLE && playing) put_dyno_gnd <= 1;
		else put_dyno_gnd <= 0;
	end // always_ff
	
	// init
	always_comb begin
		if(ps == IDLE && playing) init = 1;
		else init = 0;
	end // always_comb
	
	// adv_up
	always_comb begin
		if(ps == AIR_UP && move) adv_up = 1;
		else adv_up = 0;
	end // adv_up
	
	// adv_down
	always_comb begin
		if(ps == AIR_DOWN && move) adv_down = 1;
		else adv_down = 0;
	end // adv_down
	
	// clr_dyno_up
	always_comb begin
		if(init) clr_dyno_up = 0;
		else if(down_pressed) clr_dyno_up = 1;
		else clr_dyno_up = 0;
	end // always_comb
	
	// set_dyno_up
	always_comb begin
		if(init) set_dyno_up = 1;
		else if(down_pressed) set_dyno_up = 0;
		else set_dyno_up = 1;
	end // always_comb
	
endmodule // dynosaur_controller

/* testbench for dynosaur_controller */
module dyno_controller_testbench();
	// synchronization variables
	logic reset, clk;
	
	// status signals
	logic [10:0] dyno_y;
	
	// control signals
	logic adv_up, adv_down, init, put_dyno_gnd;
	logic set_dyno_up, clr_dyno_up, dyno_flying;
	
	// external signals
	logic collision, move, playing, down_pressed, spacebar_pressed;
	
	dynosaur_controller dut (.*);
	
	// set-up clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// provide inputs
	initial begin
		// put system into a known state
		reset <= 1;
		dyno_y <= 224;
		collision <= 0;
		move <= 0;
		playing <= 0;
		down_pressed <= 0;
		spacebar_pressed <= 0;
		@(posedge clk);
		reset <= 0;
		
		repeat(5) @(posedge clk);
		
		// start the game
		playing <= 1;
		@(posedge clk);
		repeat(5) @(posedge clk);
		
		// clr_dyno_up
		move <= 1;
		down_pressed <= 1;
		@(posedge clk);
		
		// set_dyno_up
		down_pressed <= 0;
		@(posedge clk);
		
		// jump
		spacebar_pressed <= 1;
		@(posedge clk); 
		spacebar_pressed <= 0;
		
		move <= 0;
		repeat (5) @(posedge clk);
		
		// clr_dyno_up
		move <= 1;
		down_pressed <= 1;
		@(posedge clk);
		
		// set_dyno_up
		down_pressed <= 0;
		@(posedge clk);
		
		// fly up
		for(integer i = 202; i >= 101; i--) begin
			dyno_y <= i;
			@(posedge clk);
		end
		
		// fall down
		for(integer i = 101; i <= 202; i++) begin
			dyno_y <= i;
			@(posedge clk);
		end
		
		repeat (5) @(posedge clk);
		
		// freeze
		collision <= 1;
		repeat (3) @(posedge clk);
		
		// go back to dile
		playing <= 0;
		repeat (3) @(posedge clk);
		
		$stop;
	end // initial
	
endmodule // dynosaur_controller_testbench