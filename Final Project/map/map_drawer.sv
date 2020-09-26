/* Draws sprites on the map in Dyno's Adventure
 *
 * Inputs:
 *   	clk								- clock signal
 *		reset								- active-high reset signal
 *		x, y								- position of the next pixel to draw
 *		collisions_off					- active-high signal that disables collisions
 *		playing							- active-high signal that indicates the game is being played
 *		dyno_x, dyno_y					- position of the main character
 *		dyno_current_sprite			- sprite of the main character at this time
 *		monster_list					- a list of the monsters
 *		floor_sprite					- sprite for the floor
 *		floor_offset							- horizontal floor_offset of the floor sprite, produces horizontal movement
 *		score_sprite_list				- sprite for each digit of the score
 *		score_pos_list					- horizontal position of each digit 
 *
 * Outputs:
 *		collision						- active-high signal that indicates a collision has occurred
 *		r, g, b							- red, green, and blue colors of the next pixel to draw
 *
 */
 
`include "MonsterDef.sv"
 
module map_drawer #(parameter NUM_OF_MONSTERS=2) (clk, reset, x, y, dyno_x, dyno_y, dyno_current_sprite, monster_list, floor_sprite, floor_offset, collision,
																	score_sprite_list, score_pos_list, r, g, b, collisions_off, playing);															
	input logic clk, reset, collisions_off, playing;
	input logic [10:0] x, y;
	input logic [10:0] dyno_x, dyno_y; 
	input logic [31:0][23:0] dyno_current_sprite [0:31];
	input monster_t monster_list[NUM_OF_MONSTERS-1:0];
	input	logic [7:0][23:0] floor_sprite [639:0];
	input logic [11:0] floor_offset;
	logic [7:0] r_next, g_next, b_next;
	input logic [42:0] score_sprite_list [5:0][25:0];
	input logic [10:0] score_pos_list [9:0];
	output logic collision;
	output logic [7:0] r, g, b;
	
	// keeps track of which sprite is touching the pixel (x, y) for collision detection
	logic hasBeenColoredBydyno;
	logic hasBeenColoredByMonster;
	
	always_comb begin
		hasBeenColoredBydyno = 0;
		hasBeenColoredByMonster = 0;
		// default blue sky
		r_next = 135;
		g_next = 206;
		b_next = 250;
		
		// main character
		if (x >= dyno_x && x < dyno_x + 32 && y >= dyno_y && y < dyno_y + 32) begin
			// check if this is a void spot or an actual colored pixel
			hasBeenColoredBydyno = dyno_current_sprite[x - dyno_x][y - dyno_y] ? 1'b1 : hasBeenColoredBydyno;
			if(hasBeenColoredBydyno) begin
				r_next = 8'((dyno_current_sprite[x - dyno_x][y - dyno_y] >> 16) & 8'hFF);
				g_next = 8'((dyno_current_sprite[x - dyno_x][y - dyno_y] >> 8) & 8'hFF);
				b_next = 8'((dyno_current_sprite[x - dyno_x][y - dyno_y] >> 0) & 8'hFF);
			end
		end
		
		// floor
		if (y >= 235 && y < 243) begin
			if(floor_sprite[(x + floor_offset) % 640][y - 235]) begin
				r_next = 8'((floor_sprite[(x + floor_offset) % 640][y - 235] >> 16) & 8'hFF);
				g_next = 8'((floor_sprite[(x + floor_offset) % 640][y - 235] >> 8) & 8'hFF);
				b_next = 8'((floor_sprite[(x + floor_offset) % 640][y - 235] >> 0) & 8'hFF);
			end
		end
		else if(y >= 243) begin
			// draw the ground (brown)
			r_next = 148;
			g_next = 62;
			b_next = 15;
		end
		
		// monsters
		for(integer i = 0; i < NUM_OF_MONSTERS; i++) begin
			// check if a monster sprite touches this position based on width and height
			if(x >= monster_list[i].pos_x && x < monster_list[i].pos_x + monster_list[i].width && y >= monster_list[i].pos_y && y < monster_list[i].pos_y + monster_list[i].height) begin
				// check if this is a void spot, or an actual pixel from the monster
				hasBeenColoredByMonster = monster_list[i].sprite[x - monster_list[i].pos_x][y - monster_list[i].pos_y] ? 1'b1 : hasBeenColoredByMonster;
				if(hasBeenColoredByMonster) begin
					r_next = 8'((monster_list[i].sprite[x - monster_list[i].pos_x][y - monster_list[i].pos_y] >> 16) & 8'hFF);
					g_next = 8'((monster_list[i].sprite[x - monster_list[i].pos_x][y - monster_list[i].pos_y] >> 8) & 8'hFF);
					b_next = 8'((monster_list[i].sprite[x - monster_list[i].pos_x][y - monster_list[i].pos_y] >> 0) & 8'hFF);
				end
			end
		end
		
		// draw the score, max is 999999
		for(integer i = 0; i < 6; i++) begin
			// check if a digit touches this pixel based on dimensions
			if(x >= score_pos_list[i] && x < score_pos_list[i] + 26 && y >= 20 && y < 61) begin
				// check if this is a void pixel or an actual pixel number
				if(score_sprite_list[i][x - score_pos_list[i]][y - 20]) begin
					// white
					r_next = 8'hFF; 
					g_next = 8'hFF;
					b_next = 8'hFF;
				end
			end
		end
	end
	
	// keep drawing on the screen
	always_ff @(posedge clk) begin
		if(reset) begin
			r <= 0;
			g <= 0;
			b <= 0;
		end
		else begin
			r <= r_next;
			g <= g_next;
			b <= b_next;
		end
	end
	
	// check for collisions
	always_ff @(posedge clk) begin
		if(reset) collision <= 0;
		else if(collisions_off) collision <= 0;
		else if(!playing) collision <= 0;
		else if(hasBeenColoredBydyno && hasBeenColoredByMonster) collision <= 1;
		else collision <= collision;
	end

endmodule // map_drawer

/* testbench for map_drawer */
module map_drawer_testbench();
	parameter NUM_OF_MONSTERS = 2;
	logic clk, reset, collisions_off, playing;
	logic [10:0] x, y;
	logic [10:0] dyno_x, dyno_y; 
	logic [31:0][23:0] dyno_current_sprite [0:31];
	monster_t monster_list[NUM_OF_MONSTERS-1:0];
	logic [7:0][23:0] floor_sprite [639:0];
	logic [11:0] floor_offset;
	logic [7:0] r_next, g_next, b_next;
	logic [42:0] score_sprite_list [5:0][25:0];
	logic [10:0] score_pos_list [9:0];
	
	logic collision;
	logic [7:0] r, g, b;
	
	map_drawer #(.NUM_OF_MONSTERS(NUM_OF_MONSTERS)) dut (.*);
	
	// simulate clock
	parameter CLOCK_PERIOD = 100;
	parameter SMALL_TIME = 10;
	initial begin
		clk <= 1'b0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end // forever
	end // initial
	
	// simulate dyno_current_sprite
	initial begin
		for(integer i = 0; i < 32; i++) begin
			for(integer j = 0; j < 32; j++) begin
				dyno_current_sprite[i][j] <= 24'hDD_DD_DD;
			end // for over j
		end // for over i
	end // initial
	
	// simulate floor_sprite
	initial begin
		for(integer i = 0; i < 640; i++) begin
			for(integer j = 0; j < 8; j++) begin
				floor_sprite[i][j] <= 24'hFF_FF_FF;
			end // for over j
		end // for over i
	end // initial
	
	// simulate floor_offset
	initial begin
		floor_offset <= '0;
		forever begin
			@(posedge clk);
			floor_offset <= (floor_offset >= 640) ? '0 : floor_offset + 1;
		end // forever
	end // initial
	
	// simulate monsters 
	monster_t mons0;
	monster_t mons1;
	assign mons0.width = 45; 			assign mons0.height = 36;		
	assign mons1.width = 45; 			assign mons1.height = 36;
	assign monster_list[0] = mons0;
	assign monster_list[1] = mons1;
	
	initial begin
		for(integer i = 0; i < 45; i++) begin
			for(integer j = 0; j < 36; j++) begin
				mons0.sprite[i][j] <= 24'hAA_AA_AA;
				mons1.sprite[i][j] <= 24'hBB_BB_BB;
			end // for over j
		end // for over i
		
		mons0.pos_x <= 200;
		mons0.pos_y <= 200;
		mons1.pos_x <= 300;
		mons1.pos_y <= 300;
	end // initial
	
	// simulate score
	initial begin
		for(integer i = 0; i < 6; i++) begin
			for(integer j = 0; j < 26; j++) begin
				score_sprite_list[i][j] = 42'hEE_EE_EE_EE_EE;
			end // for over j
		end // for over i
		
		score_pos_list[0] <= 11'(640 - 2   * 30);
		score_pos_list[1] <= 11'(640 - 3   * 30);
		score_pos_list[2] <= 11'(640 - 4   * 30);
		score_pos_list[3] <= 11'(640 - 5   * 30);
		score_pos_list[4] <= 11'(640 - 6   * 30);
		score_pos_list[5] <= 11'(640 - 7   * 30);
		score_pos_list[6] <= 11'(640 - 8   * 30);
		score_pos_list[7] <= 11'(640 - 9   * 30);
		score_pos_list[8] <= 11'(640 - 10  * 30);
		score_pos_list[9] <= 11'(640 - 11  * 30);
	end // initial
	
	// provide inputs
	initial begin
		// reset system to a known state
		reset <= 1'b1;
		collisions_off <= 1'b0;
		playing <= 1'b1;
		x <= 0;
		y <= 0;
		dyno_x <= 100;
		dyno_y <= 100;
		
		@(posedge clk);
		reset <= 1'b0;
		
		// test score display
		x <= 640 - 2 * 30 + 5;
		y <= 50;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == g && g == b && b == 255) $display ("Score color is correct at t= %t", $time);
		else $error("Score color is not correct at t=%t", $time);
		
		// test dyno display
		x <= 100 + 10;
		y <= 100 + 15;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == g && g == b && b == 8'hDD) $display ("Dyno color is correct at t= %t", $time);
		else $error("Dyno color is not correct at t=%t", $time);
		
		// test monster display 
		x <= 200 + 10;
		y <= 200 + 12;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == g && g == b && b == 8'hAA) $display ("Monster #0 color is correct at t= %t", $time);
		else $error("Monster #0 color is not correct at t=%t", $time);
		
		x <= 300 + 10;
		y <= 300 + 12;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == g && g == b && b == 8'hBB) $display ("Monster #1 color is correct at t= %t", $time);
		else $error("Monster #1 color is not correct at t=%t", $time);
		
		// test floor display
		x <= 100;
		y <= 235 + 3;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == g && g == b && b == 8'hFF) $display ("Floor color is correct at t= %t", $time);
		else $error("Floor color is not correct at t=%t", $time);
		
		// test ground display 
		x <= 100;
		y <= 400;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == 148 && g == 62 && b == 15) $display ("Ground color is correct at t= %t", $time);
		else $error("Ground color is not correct at t=%t", $time);
		
		// test background display
		x <= 10;
		y <= 10;
		@(posedge clk);
		#(SMALL_TIME);
		assert(r == 135 && g == 206 && b == 250) $display ("Background color is correct at t= %t", $time);
		else $error("Background color is not correct at t=%t", $time);
		
		// test collision
		mons0.pos_x <= 100;
		mons0.pos_y <= 100;
		@(posedge clk);
		#(SMALL_TIME);
		assert(!collision) $display ("Will detect a collision: ");
		else $error ("Collision occurred earlier than expected");
		x <= 100;
		y <= 100;
		@(posedge clk);
		#(SMALL_TIME);
		assert(collision) $display("Collision occurred! at %t", $time);
		else $error("Collision did not occur. Check %time", $time);
		
		// test collisions_off
		collisions_off <= 1'b1;
		@(posedge clk);
		#(SMALL_TIME);
		assert(!collision) $display("Success, collisions disabled");
		else $error("Could not disable collisions");
		
		// test playing
		collisions_off <= 1'b0;
		@(posedge clk);
		playing <= 1'b0;
		@(posedge clk);
		#(SMALL_TIME);
		assert(!collision) $display("Now on menu. The only thing to check here is collisions are off: Correct");
		else $error("Check the signal playing at %t", $time);
		
		
		$stop;
	end // initial
	
endmodule // map_drawer