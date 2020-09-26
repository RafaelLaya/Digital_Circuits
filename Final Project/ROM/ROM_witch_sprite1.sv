/*	ROM module that stores Sprite #1 for witch
 *		Outputs:
 *			witch_sprite1		- Sprite #1 for witch
 *
 * Position [x][y][{r,g,b}] contains pixel at (x, y) where r, g, b are 8 bits each
 * (0, 0) is at the top-left
 * Width 45, Height 36, Color-depth 24
*/

module ROM_witch_sprite1(witch_sprite1);

	output logic [35:0][23:0] witch_sprite1[44:0];

	assign witch_sprite1[0] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[1] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[2] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[3] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[4] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[5] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[6] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[7] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[8] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[9] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[10] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd16777215, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16711680, 24'd16711680, 24'd16711680, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[11] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd6438947, 24'd16777215, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16711680, 24'd16711680, 24'd16711680, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[12] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16711680, 24'd16711680, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[13] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16777215, 24'd16777215, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[14] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16777215, 24'd16777215, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[15] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd16777215, 24'd16777215, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd1118481, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[16] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[17] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[18] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd6438947, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[19] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[20] =  { 24'd0, 24'd0, 24'd0, 24'd6438947, 24'd6438947, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[21] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd5291375, 24'd5291375, 24'd5291375, 24'd5291375, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0 };
	assign witch_sprite1[22] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd3092270, 24'd3092270, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[23] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4564320, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd3092270, 24'd3092270, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[24] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[25] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[26] =  { 24'd0, 24'd0, 24'd0, 24'd4564320, 24'd4564320, 24'd4564320, 24'd6438947, 24'd6438947, 24'd6438947, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[27] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd3745617, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[28] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[29] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd9607588, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784 };
	assign witch_sprite1[30] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd9607588, 24'd9607588, 24'd9607588, 24'd0, 24'd0, 24'd3745617, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0 };
	assign witch_sprite1[31] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[32] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[33] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[34] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[35] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[36] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[37] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[38] =  { 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd4402784, 24'd4402784, 24'd4402784, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[39] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[40] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd10123859, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[41] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[42] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd10123859, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[43] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign witch_sprite1[44] =  { 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };

endmodule // ROM_witch_sprite1