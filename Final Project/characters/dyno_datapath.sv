/* Implements a datapath for the main character
 *
 * Inputs:
 *   	clk					- clock signal
 *		reset					- active-high reset signal
 *   	clr_dyno_up			- active-high control signal that tells datapath to CLEAR the standing position of dyno
 *		set_dyno_up			- active-high control signal that tells datapath to SET the standing position of dyno
 *		adv_up				- active-high control signal that tells datapath to set dyno's position higher on the screen
 *		adv_down				- active-high control signal that tells datapath to set dyno's position lower on the screen
 *		init					- active-high control signal that tells datapath to initialize dyno
 *		put_dyno_gnd		- active-high control signal that tells datapath to put dyno on ground-level (vertical position)
 *
 * Outputs:
 *		dyno_x				- indicates the horizontal position of dyno
 *		dyno_y				- indicates the vertical position of dyno
 *		dyno_up				- active-high signal that indicates dyno is standing up
 *		dyno_flying			- active-high signal that indicates dyno is on the air
 *		
 */

module dynosaur_datapath(reset, clk, clr_dyno_up, set_dyno_up, init, dyno_x, dyno_y, dyno_up, adv_up, adv_down, put_dyno_gnd);
	// synchronization variables
	input logic reset, clk;
	
	// status signals
	output logic dyno_up;
	output logic [10:0] dyno_y;
	
	// control signals
	input logic init, put_dyno_gnd;
	input logic set_dyno_up, clr_dyno_up, adv_up, adv_down;
	
	// external signals
	output logic [10:0] dyno_x;
	
	// dyno_up
	always_ff @(posedge clk) begin
		if(reset) dyno_up <= 0;
		else if(set_dyno_up) dyno_up <= 1;
		else if(clr_dyno_up) dyno_up <= 0;
		else dyno_up <= dyno_up;
	end // dyno_up
	
	// dyno_x
	assign dyno_x = 40;
	
	// dyno_y
	always_ff @(posedge clk) begin
		if(reset || init || put_dyno_gnd) dyno_y <= 202;
		else if(adv_up) dyno_y <= dyno_y - 11'(1);
		else if(adv_down) dyno_y <= dyno_y + 11'(1);
	end // always_ff
	
endmodule // dynosaur_datapath

/* testbench for dynosaur_datapath */
module dyno_datapath_testbench();
	// synchronization variables
	logic reset, clk;
	
	// status signals
	logic dyno_up;
	logic [10:0] dyno_y;
	
	// control signals
	logic pick_new_y, init, put_dyno_gnd;
	logic set_dyno_up, clr_dyno_up, adv_up, adv_down, dyno_flying;
	
	// external signals
	logic [10:0] dyno_x;
	
	dynosaur_datapath dut (.*);
	
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
		// reset system to a known state
		reset <= 1;
		adv_up <= 0;
		adv_down <= 0;
		init <= 0;
		set_dyno_up <= 0;
		clr_dyno_up <= 0;
		dyno_flying <= 0;
		pick_new_y <= 0;
		put_dyno_gnd <= 0;
		@(posedge clk);
		reset <= 0;
		
		// init
		init <= 1;
		@(posedge clk);
		init <= 0;
		
		// make the dyno kneel down
		clr_dyno_up <= 1;
		repeat (2) @(posedge clk);
		clr_dyno_up <= 0;
		
		// make it stand up
		set_dyno_up <= 1;
		repeat (2) @(posedge clk);
		set_dyno_up <= 0;
		repeat (2) @(posedge clk);
		
		// let's fly
		adv_up <= 1;
		dyno_flying <= 1;
		repeat (24) begin
			pick_new_y <= 1'b1;
			@(posedge clk);
		end // repeat(24)
		dyno_flying <= 0;
		adv_up <= 0;
	
		// fall down
		adv_down <= 1;
		dyno_flying <= 1;
		repeat (24) begin
			pick_new_y <= 1'b1;
			@(posedge clk);
		end // repeat(24)
		dyno_flying <= 0;
		adv_down <= 0;
		put_dyno_gnd <= 1;
		
		repeat (3) @(posedge clk);
		
		$stop;
	end // initial
endmodule // dynosaur_datapath_testbench