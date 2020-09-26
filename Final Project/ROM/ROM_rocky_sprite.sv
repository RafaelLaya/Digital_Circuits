/*	ROM module that stores Sprite for rocky
 *		Outputs:
 *			rocky_sprite		- Sprite for rocky
 *
 * Position [x][y][{r,g,b}] contains pixel at (x, y) where r, g, b are 8 bits each
 * (0, 0) is at the top-left
 * Width 45, Height 36, Color-depth 24
*/


module ROM_rocky_sprite(rocky_sprite);

	output logic [35:0][23:0] rocky_sprite [44:0];
		
	assign rocky_sprite[0] =  { 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[1] =  { 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[2] =  { 24'd6305811, 24'd6305811, 24'd11040862, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[3] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[4] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[5] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[6] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[7] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[8] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[9] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[10] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[11] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd11040862, 24'd13012591, 24'd13012591, 24'd13012591, 24'd11040862, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[12] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[13] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[14] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[15] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd16777215, 24'd16777215, 24'd16777215, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[16] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd1973790, 24'd1973790, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[17] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd1973790, 24'd16777215, 24'd16777215, 24'd1973790, 24'd1973790, 24'd1973790, 24'd16777215, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[18] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd1973790, 24'd16777215, 24'd16777215, 24'd1973790, 24'd1973790, 24'd1973790, 24'd16777215, 24'd16777215, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[19] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd1973790, 24'd16777215, 24'd16777215, 24'd1973790, 24'd1973790, 24'd1973790, 24'd16777215, 24'd16777215, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[20] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd1973790, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[21] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd1973790, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[22] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd1973790, 24'd1973790, 24'd16777215, 24'd16777215, 24'd16777215, 24'd16777215, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[23] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd1973790, 24'd1973790, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[24] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[25] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[26] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[27] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[28] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd1973790, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[29] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[30] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[31] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[32] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[33] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[34] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[35] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[36] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[37] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[38] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd13012591, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[39] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[40] =  { 24'd6305811, 24'd6305811, 24'd13012591, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[41] =  { 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[42] =  { 24'd6305811, 24'd6305811, 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[43] =  { 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };
	assign rocky_sprite[44] =  { 24'd6305811, 24'd6305811, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0, 24'd0 };

endmodule // ROM_rocky_sprite