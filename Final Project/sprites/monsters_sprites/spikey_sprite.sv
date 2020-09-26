/* Sprite for monster 'spikey'
 *
 * Outputs:
 *   	spikey_sprite			- sprite for spikey
 *
 *		Width of sprite is 45, height 36, and color-depth 24. 
 *    highest 8 bits are red, medium 8 bits are green, lowest 8 bits are blue
 */

module ROM_spikey_sprite(spikey_sprite);
	output logic [35:0][23:0] spikey_sprite [44:0];

	assign spikey_sprite[0] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[1] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[2] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[3] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[4] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[5] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[6] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[7] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[8] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[9] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[10] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[11] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16711680, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[12] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd26840, 24'd26840, 24'd16777215, 24'd6504747, 24'd6504747, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[13] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd16777215, 24'd6504747, 24'd6504747, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[14] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[15] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd855309, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[16] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0 };
	assign spikey_sprite[17] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0 };
	assign spikey_sprite[18] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0 };
	assign spikey_sprite[19] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16711680, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[20] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16711680, 24'd26840, 24'd26840, 24'd16777215, 24'd6504747, 24'd6504747, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[21] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd26840, 24'd26840, 24'd16777215, 24'd6504747, 24'd6504747, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215 };
	assign spikey_sprite[22] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd26840, 24'd26840, 24'd16777215, 24'd6504747, 24'd6504747, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215 };
	assign spikey_sprite[23] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd16711680, 24'd16711680, 24'd16711680, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[24] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[25] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[26] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[27] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[28] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0 };
	assign spikey_sprite[29] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0 };
	assign spikey_sprite[30] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[31] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[32] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[33] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[34] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[35] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[36] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd26840, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd0, 24'd0 };
	assign spikey_sprite[37] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[38] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[39] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd921102, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[40] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[41] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[42] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[43] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign spikey_sprite[44] =  { 24'd9067835, 24'd9067835, 24'd9067835, 24'd9067835, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };

endmodule // ROM_spikey_sprite