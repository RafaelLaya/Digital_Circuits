/* Selects which screen is shown on the VGA display                       
 * 
 * Inputs:
 *   playing							- active-high signal indicates the game is being played
 *	  r_map, g_map, b_map			- red, green, and blue values from map_drawer. Should be
 *									  		connected to signals of the same name in map_drawer.
 *	  r_menu, g_menu, b_menu		- red, green, and blue values from menu. Should be 
 *											connected to signals of the same name in menu
 *
 * Outputs:
 *   AUD_XCK	- should connect to top-level entity I/O of the same name
 *                                              
 *
*/
module display_mux(playing, r, g, b, r_map, g_map, b_map, r_menu, g_menu, b_menu);
	input logic playing;
	input logic [7:0] g_map, r_map, b_map, r_menu, g_menu, b_menu;
	output logic [7:0] r, g, b;
	
	always_comb begin
		if(playing) begin
			r = r_map;
			b = b_map;
			g = g_map;
		end // if (playing)
		else begin
			r = r_menu;
			g = g_menu;
			b = b_menu;
		end // else
	end // always_comb

endmodule // display_mux

/* testbench for display_mux */
module display_mux_testbench();
	logic playing;
	logic [7:0] g_map, r_map, b_map, r_menu, g_menu, b_menu;
	logic [7:0] r, g, b;
	
	display_mux dut (.*);
	
	// provide inputs
	parameter WAIT_TIME = 100;
	initial begin
		playing <= 1'b0;
		r_menu <= '0;
		g_menu <= '0;
		b_menu <= '0;
		r_map <= '0;
		g_map <= '0;
		b_map <= '0;
		#(WAIT_TIME);
		
		// draw from the menu
		r_menu <= 8'hAA;
		g_menu <= 8'hBB;
		b_menu <= 8'hCC;
		#(WAIT_TIME);
		
		// draw from the game
		playing <= 1'b1;
		r_map <= 8'hDD;
		g_map <= 8'hEE;
		b_map <= 8'hFF;
		#(WAIT_TIME);
		
		$stop;
	end // initial
	
endmodule // display_mux_testbench