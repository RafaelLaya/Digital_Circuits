/*	ROM module that stores Sprite #2 for dragon
 *		Outputs:
 *			dragon_sprite2			- sprite #2 for dragon
 *
 * Position [x][y][{r,g,b}] contains pixel at (x, y) where r, g, b are 8 bits each
 * (0, 0) is at the top-left
 * Width 45, Height 36, Color-depth 24
*/
module ROM_dragon_sprite2(dragon_sprite2);
	output logic [35:0][23:0] dragon_sprite2 [44:0];
	

	assign dragon_sprite2[0] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[1] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[2] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[3] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[4] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd5046016, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[5] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[6] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[7] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[8] =  { 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[9] =  { 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[10] =  { 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[11] =  { 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[12] =  { 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[13] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[14] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[15] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[16] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[17] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[18] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[19] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[20] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[21] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[22] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[23] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0 };
	assign dragon_sprite2[24] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0 };
	assign dragon_sprite2[25] =  { 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0 };
	assign dragon_sprite2[26] =  { 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0 };
	assign dragon_sprite2[27] =  { 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0 };
	assign dragon_sprite2[28] =  { 24'd13107200, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[29] =  { 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[30] =  { 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[31] =  { 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd13107200, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[32] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[33] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[34] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[35] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[36] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[37] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd16711680, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[38] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[39] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[40] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[41] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[42] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[43] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd13107200, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign dragon_sprite2[44] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
		
endmodule // ROM_dragon_sprite2