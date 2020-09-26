/* Implements Dyno's Adventure Game
 *
 * Inputs:
 *   	VGA_R, VGA_G, VGA_B
 *		KEY											- KEY[3] is used as a reset. Press KEY[3] to reset the system.
 *		CLOCK_50, CLOCK2_50						- Internal 50MHz clocks
 *		AUD_DACLRCK, AUD_ADCLRCK, AUD_CLK	- Clock signals from the audio CODEC
 *		AUD_ADCDAT									- ADC used for the audio CODEC
 *
 *	inouts:
 *		FPGA_I2C_SDAT						- I2C Data signal, for audio
 *
 * Outputs:
 *		HEX0 ... HEX5						- Unused HEX displays
 *		LEDR									- Unused LEDs
 *		VGA_R, VGA_G, VGA_B				- Color signals of the VGA
 *		VGA_BLANK_N							- VGA Blank signal
 *		VGA_CLK								- Clock signal of the VGA
 *    VGA_HS, VGA_VS, VGA__N		- Sync signals of the VGA (Horiz., Verti., Enable)
 *		PS2_DAT								- PS2 Data signal, used for the keyboard
 *		PS2_CLK								- PS2 Clock signal, used for the keyboard
 *		FPGA_I2C_SCLK						- I2C Clock signal, for audio
 *		
 *		AUD_XCK								- Clock signal generated for audio
 *		AUD_DACDAT							- DAC data for the CODEC
 *
 * IMPORTANT: Make sure all simulation profiles in Sound_Simul.sv are commented out, before compiling and uploading to the DE1_SoC
 */

/*
 * Adding a new monster requires: 
 * 0. Declare the sprite
 * 1. Add one to NUM_OF_MONSTERS
 * 2. Declare a monster_t structure. Initialize width and height
 * 3. Use basic_monster
 * 4. Use sprite_rotator
 * 5. Add monster_t struct to the monster_list
 */	

`include "MonsterDef.sv"
 
module DE1_SoC (
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	LEDR,
	KEY, 
	CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, PS2_DAT, PS2_CLK, 	FPGA_I2C_SCLK, 
	FPGA_I2C_SDAT, 
	AUD_XCK, 
	AUD_DACLRCK, 
	AUD_ADCLRCK, 
	AUD_BCLK, 
	AUD_ADCDAT, 
	AUD_DACDAT, CLOCK2_50);
	
	// LEDRs and HEX
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	
	// clock and reset
	input CLOCK_50, CLOCK2_50;
	input logic [3:0] KEY;
	
	// ps2 (keyboard)
	input logic PS2_DAT, PS2_CLK;
	
	// VGA (display)
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	// audio (aux)
	output logic FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	output logic AUD_XCK;
	input logic AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input logic AUD_ADCDAT;
	output logic AUD_DACDAT;
	
	// system clock and reset
	assign clk = CLOCK_50;
	assign reset = ~KEY[0];
	
	// keyboard internal signals
	logic space;
	logic down_pressed;
	logic valid;
	logic makeBreak;
	logic [7:0] outCode;
	logic but_up_pre, but_sel_pre, but_down, but_up, but_sel;
	
	// audio internal signals
	logic read_ready, write_ready, read, write;
	logic [23:0] readdata_left, readdata_right;
	logic signed [23:0] writedata_left, writedata_right;
	
	// main character signals
	logic [10:0] dyno_x;
	logic [10:0] dyno_y;
	logic dyno_flying;
	logic dyno_up;
	
	// VGA internal signals
	logic color;
	logic [10:0] x, y;
	logic [7:0] r, g, b, r_map, g_map, b_map, r_menu, g_menu, b_menu;
	
	// clock, reset, and control signals
	logic reset;
	logic clk;
	logic move;
	logic next_level;
	
	// state of the game, menu, and settings
	logic playing;
	logic [19:0] score;
	logic [42:0] score_sprite_list [5:0][25:0];
	logic [10:0] score_pos_list [9:0];
	logic collision;
	logic soundOn, anim;
	logic slow_down;
	logic collisions_off;
	logic game_start;
	
	// declare monsters
	parameter NUM_OF_MONSTERS = 12;					
	logic [NUM_OF_MONSTERS-1:0] encoding_list;
	monster_t monster_list[NUM_OF_MONSTERS-1:0];
	monster_t dragon; 		assign dragon.width = 45; 			assign dragon.height = 36;		
	monster_t spikes; 		assign spikes.width = 45; 			assign spikes.height = 36;
	monster_t witch;  		assign witch.width  = 45; 			assign witch.height  = 36;
	monster_t fireball; 		assign fireball.width = 45; 		assign fireball.height = 36;
	monster_t rocky; 			assign rocky.width = 45; 			assign rocky.height = 36;
	monster_t eye; 			assign eye.width = 45; 				assign eye.height = 36;
	monster_t spikey; 		assign spikey.width = 45; 			assign spikey.height = 36;
	monster_t rocket; 		assign rocket.width = 45; 			assign rocket.height = 36;
	monster_t flying_eye; 	assign flying_eye.width = 45; 	assign flying_eye.height = 36;
	monster_t topo; 			assign topo.width = 45; 			assign topo.height = 36;
	monster_t ghost; 			assign ghost.width = 45; 			assign ghost.height = 36;
	monster_t spiky_wood; 	assign spiky_wood.width = 45; 	assign spiky_wood.height = 36;
	assign monster_list[0] = dragon;
	assign monster_list[1] = spikes;
	assign monster_list[2] = witch;
	assign monster_list[3] = fireball;
	assign monster_list[4] = rocky;
	assign monster_list[5] = eye;
	assign monster_list[6] = spikey;
	assign monster_list[7] = rocket;
	assign monster_list[8] = flying_eye;
	assign monster_list[9] = topo;
	assign monster_list[10] = ghost;
	assign monster_list[11] = spiky_wood;
	
	// unused hex displays and LEDRs
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR[9:0] = '0;
	
	// sprites
	logic [11:0] floor_offset;
	logic [31:0][23:0] dyno_current_sprite [0:31];
	logic [7:0][23:0] floor_sprite [639:0];
	logic [35:0][23:0] dragon_sprite3 [44:0];
	logic [35:0][23:0] dragon_sprite2 [44:0];
	logic [35:0][23:0] dragon_sprite1 [44:0];
	logic [35:0][23:0] spikes_sprite[44:0];
	logic [35:0][23:0] witch_sprite0[44:0];
	logic [35:0][23:0] witch_sprite1[44:0];
	logic [35:0][23:0] rocky_sprite[44:0];
	logic [35:0][23:0] fireball_sprite0[44:0];
	logic [35:0][23:0] eye_sprite[44:0];
	logic [35:0][23:0] spikey_sprite[44:0];
	logic [35:0][23:0] rocket_sprite[44:0];
	logic [35:0][23:0] flying_eye_sprite[44:0];
	logic [35:0][23:0] ghost_sprite[44:0];
	logic [35:0][23:0] topo_sprite[44:0];
	logic [35:0][23:0] spiky_wood_sprite[44:0];
	logic [35:0][23:0] dragon_sprite_list[3][44:0];
	logic [35:0][23:0] witch_sprite_list[2][44:0];
	
	// Get sprites from memory
	ROM_dragon_sprite3 sprite_dragon3_mem (.dragon_sprite3);
	ROM_dragon_sprite2 sprite_dragon2_mem (.dragon_sprite2);
	ROM_dragon_sprite1 sprite_dragon1_mem (.dragon_sprite1);
	ROM_floor_sprite sprite_floor_mem (.floor_sprite);
	ROM_spikes_sprite sprite_spike_mem (.spikes_sprite);
	ROM_witch_sprite0 sprite_witch0_mem (.witch_sprite0);
	ROM_witch_sprite1 sprite_witch1_mem (.witch_sprite1);
	ROM_fireball_sprite sprite_fireball0_mem (.fireball_sprite(fireball_sprite0));
	ROM_rocky_sprite sprite_rocky_mem (.rocky_sprite);
	ROM_eye_sprite sprite_eye_mem (.eye_sprite);
	ROM_spikey_sprite sprite_spikey_mem (.spikey_sprite);
	ROM_rocket_sprite sprite_rocket_mem (.rocket_sprite);
	ROM_flying_eye_sprite sprite_flying_eye_mem (.flying_eye_sprite);
	ROM_topo_sprite sprite_topo_mem (.topo_sprite);
	ROM_ghost_sprite sprite_ghost_mem (.ghost_sprite);
	ROM_spiky_wood_sprite sprite_spiky_wood_mem (.spiky_wood_sprite);
	assign dragon_sprite_list[0] = dragon_sprite1;
	assign dragon_sprite_list[1] = dragon_sprite2;
	assign dragon_sprite_list[2] = dragon_sprite3;
	assign witch_sprite_list[0] = witch_sprite0;
	assign witch_sprite_list[1] = witch_sprite1;
	
	// static sprites
	assign spikes.sprite = spikes_sprite;
	assign fireball.sprite = fireball_sprite0;
	assign rocky.sprite = rocky_sprite;
	assign eye.sprite = eye_sprite;
	assign spikey.sprite = spikey_sprite;
	assign rocket.sprite = rocket_sprite;
	assign flying_eye.sprite = flying_eye_sprite;
	assign topo.sprite = topo_sprite;
	assign ghost.sprite = ghost_sprite;
	assign spiky_wood.sprite = spiky_wood_sprite;
	
	// animations
	floor_animator floor_animation (.clk, .reset, .floor_offset, .collision, .move);
	dyno_sprite_selector user_sprite_sel (.reset, .clk, .dyno_current_sprite, .move, .collision, .dyno_up, .dyno_flying, .anim);
	sprite_rotator #(.WIDTH(45), .HEIGHT(36), .NUM_SPRITES(3)) rotator_dragon (.reset, .clk, .sprites_list(dragon_sprite_list), .sprite(dragon.sprite), .move, .collision, .anim);
	sprite_rotator #(.WIDTH(45), .HEIGHT(36), .NUM_SPRITES(2)) rotator_witch (.reset, .clk, .sprites_list(witch_sprite_list), .sprite(witch.sprite), .move, .collision, .anim);
	
	// dyno logic
	dyno main_char (.reset(reset), .clk(CLOCK_50), .collision, .move(move), .playing, .down_pressed, .spacebar_pressed(space), .dyno_x, .dyno_y, .dyno_up, .dyno_flying);
	
	// monster logic
	monster_picker #(.NUM_OF_MONSTERS(NUM_OF_MONSTERS)) picker (.clk, .reset, .encoding_list, .move, .next_level, .playing);
	
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(0), .ENCODING_SIZE(NUM_OF_MONSTERS)) dragon_monster
						(.clk, .reset, .monster_x(dragon.pos_x), .monster_y(dragon.pos_y), .encoding_list, .move, .collision, .playing);	
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(1), .ENCODING_SIZE(NUM_OF_MONSTERS)) spikes_monster
						(.clk, .reset, .monster_x(spikes.pos_x), .monster_y(spikes.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(2), .ENCODING_SIZE(NUM_OF_MONSTERS)) witch_monster
						(.clk, .reset, .monster_x(witch.pos_x),  .monster_y(witch.pos_y),  .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(3), .ENCODING_SIZE(NUM_OF_MONSTERS)) rocky_monster
						(.clk, .reset, .monster_x(rocky.pos_x), .monster_y(rocky.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(4), .ENCODING_SIZE(NUM_OF_MONSTERS)) fireball_monster
						(.clk, .reset, .monster_x(fireball.pos_x), .monster_y(fireball.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(5), .ENCODING_SIZE(NUM_OF_MONSTERS)) eye_monster
						(.clk, .reset, .monster_x(eye.pos_x), .monster_y(eye.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(6), .ENCODING_SIZE(NUM_OF_MONSTERS)) rocket_monster
						(.clk, .reset, .monster_x(rocket.pos_x), .monster_y(rocket.pos_y), .encoding_list, .move, .collision, .playing);				
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(7), .ENCODING_SIZE(NUM_OF_MONSTERS)) spikey_monster
						(.clk, .reset, .monster_x(spikey.pos_x), .monster_y(spikey.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(8), .ENCODING_SIZE(NUM_OF_MONSTERS)) flying_eye_monster
						(.clk, .reset, .monster_x(flying_eye.pos_x), .monster_y(flying_eye.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(9), .ENCODING_SIZE(NUM_OF_MONSTERS)) topo_monster
						(.clk, .reset, .monster_x(topo.pos_x), .monster_y(topo.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(0), .ID(10), .ENCODING_SIZE(NUM_OF_MONSTERS)) ghost_monster
						(.clk, .reset, .monster_x(ghost.pos_x), .monster_y(ghost.pos_y), .encoding_list, .move, .collision, .playing);
						
	basic_monster #(.WIDTH(45), .HEIGHT(36), .GROUND_NPC(1), .ID(11), .ENCODING_SIZE(NUM_OF_MONSTERS)) spiky_wood_monster
						(.clk, .reset, .monster_x(spiky_wood.pos_x), .monster_y(spiky_wood.pos_y), .encoding_list, .move, .collision, .playing);
	
	// difficulty and score
	speed_selector difficulty_modifier (.reset, .clk, .score, .move, .next_level, .slow_down);
	
	score_manager scoreboard (.clk, .reset, .move, .score_sprite_list, .score_pos_list, .collision, .playing, .score, .dyno_up);
	
	// rendering
	main_control control (.clk, .reset, .game_start, .collision, .playing, .valid, .makeBreak, .outCode);
	
	map_drawer #(.NUM_OF_MONSTERS(NUM_OF_MONSTERS)) game_drawer 
					(.clk, .reset, .x, .y, .dyno_x, .dyno_y, .dyno_current_sprite, .monster_list, .floor_sprite, .floor_offset, .collision, 
					.score_sprite_list, .score_pos_list, .r(r_map), .g(g_map), .b(b_map), .collisions_off, .playing);
					
	menu game_menu (.clk, .reset, .x, .y, .r(r_menu), .g(g_menu), .b(b_menu), .playing, .but_up, .but_down, .but_sel, .game_start, .soundOn, .anim);
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x(x[9:0]), .y(y[8:0]), .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	// Sound
	assign read = read_ready;
	assign write = write_ready;
	sound sound_player (.clk, .reset, .playing, .collision, .jump(space), .next_level, .writedata_left, .writedata_right, .dyno_flying, .soundOn);
	
	audio_and_video_config cfg(
		CLOCK_50,
		reset,
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);
	clock_generator my_clock_gen(
		.CLOCK2_50,
		.reset,
		.AUD_XCK
	);
	audio_codec codec(
		CLOCK_50,
		reset,
		read,	
		write,
		writedata_left, 
		writedata_right,
		AUD_ADCDAT,
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);
	
	// keyboard 
	rising_edge_checker checker_down (.in(down_pressed), .out(but_down), .reset, .clk);
	rising_edge_checker checker_up   (.in(but_up_pre), .out(but_up), .reset, .clk);
	rising_edge_checker checker_sel  (.in(but_sel_pre), .out(but_sel), .reset, .clk);
	keyboard_press_driver keyboard (.CLOCK_50, .valid, .makeBreak, .outCode, .PS2_DAT, .PS2_CLK, .reset);
	keyboard_input_filter #(.MAKE(8'h75), .BREAK(8'h75)) up_key_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(but_up_pre));
	keyboard_input_filter #(.MAKE(8'h5A), .BREAK(8'h5A)) sel_key_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(but_sel_pre));
	keyboard_input_filter #(.MAKE(8'h29), .BREAK(8'h29)) space_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(space));
	keyboard_input_filter #(.MAKE(8'h72), .BREAK(8'h72)) down_key_filter (.clk, .reset, .valid, .makeBreak, .outCode, .out(down_pressed));
	cheat_check #(.L0(8'h21), .L1(8'h33), .L2(8'h43), .L3(8'h4B), .L4(8'h4B)) chill_check (.clk, .reset, .outCode, .makeBreak, .valid, .out(slow_down), .playing, .collision);
	cheat_check #(.L0(8'h4D), .L1(8'h24), .L2(8'h1C), .L3(8'h21), .L4(8'h24)) peace_check (.clk, .reset, .outCode, .makeBreak, .valid, .out(collisions_off), .playing, .collision);
	
	// choose between menu and game
	display_mux screen_selector (.playing, .r, .g, .b, .r_map, .g_map, .b_map, .r_menu, .g_menu, .b_menu);
	
endmodule // DE1_SoC
