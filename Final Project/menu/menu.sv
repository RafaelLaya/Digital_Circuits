/* Implements a datapath for the main character
 *
 * Inputs:
 *   	clk									- Clock signal
 *		reset									- active-high reset signal
 *		playing								- active-high signal tells if the game is being played
 *		but_up, but_down, but_sel		- active-high signals indicate if arrows up, down, or enter are pressed
 *		x, y									- position of the next pixel to draw
 *
 * Outputs:
 *		r, g, b				- Color triplet of the pixel to draw if on the menu screen
 *		game_start			- Active-high pulses indicate the user wants to start the game
 *		soundOn				- active-high signal indicates if sound is enabled
 *		anim					- active-high signal indicates if animations are enabled
 *		
 */
 
 `timescale 1 ps / 1 ps

module menu(clk, reset, x, y, r, g, b, playing, but_up, but_down, but_sel, game_start, soundOn, anim);

    input logic clk, reset, playing;
    input logic but_up, but_down, but_sel;
    input logic [10:0] x;
	 input logic [10:0] y;
    output logic [7:0] r, g, b;
    output logic game_start;
	 output logic soundOn, anim;
	 logic nsoundOn, nanim;

    parameter num_option = 2;
    parameter start_game_option = 0, setting_option = 1;
    logic [1:0] option, noption;
	 logic [1:0] suboption, nsuboption;
    logic game_start_temp, game_start_out;

    parameter [10:0] back_dx = 300, back_dy = 260, back_width = 180, back_height = 220;
    parameter [10:0] base_pointer_dy = 360, base_pointer_dx = 520, pointer_width = 73, pointer_height = 41;
    parameter [10:0] option_dx = 106, option_dy = 280, option_width = 200, option_height = 180;
	 parameter [10:0] opt_width = 35, opt_height = 25;
	 parameter [10:0] opt1_dx = 210, opt1_dy = 345, opt2_dx = 210, opt2_dy = 370;
	 logic [10:0]  pointer_dy, pointer_dx;
    logic [23:0] back_pixel;
	 logic [23:0] pointer_pixel;
	 logic [23:0] option_pixel;
	 logic [23:0] on1_pixel;
	 logic [23:0] on2_pixel;
	 logic [23:0] off1_pixel;
	 logic [23:0] off2_pixel;
	 logic [15:0] mem_address;
	 logic [11:0] pointer_addr;
	 logic [15:0] option_addr;
	 logic [11:0] opt1_addr;
	 logic [11:0] opt2_addr;
	 logic back_write, nback_write;
	 logic pointer_write, npointer_write;
	 logic option_write, noption_write;
	 logic opt1_write, nopt1_write;
	 logic opt2_write, nopt2_write;
	 logic opt1_pix_avail, opt2_pix_avail;
	 
	 assign mem_address = (y - back_dy) * back_width + (x - back_dx);
	 assign pointer_addr = (y - pointer_dy) * pointer_width + (x - pointer_dx);
	 assign option_addr = (y - option_dy) * option_width + (x - option_dx);
	 assign opt1_addr = (y - opt1_dy) * opt_width + (x - opt1_dx);
	 assign opt2_addr = (y - opt2_dy) * opt_width + (x - opt2_dx);
	 
	 back_mem back_rom(mem_address, clk, back_pixel);
	 pointer_mem p_mem(pointer_addr, clk, pointer_pixel);
	 option_mem opt_mem(option_addr, clk, option_pixel);
	 on_mem on1_mem(opt1_addr, clk, on1_pixel);
	 off_mem off1_mem(opt1_addr, clk, off1_pixel);
	 on_mem on2_mem(opt2_addr, clk, on2_pixel);
	 off_mem off2_mem(opt2_addr, clk, off2_pixel);

    // Menu Logic Section
	 rising_edge_checker key_reg_start (.in(game_start_temp), .out(game_start), .reset(reset), .clk(clk));
	 
    always_comb begin
        // Next Option Logic
		  if (playing) begin
				noption = option;
				nsuboption = suboption;
		  end else if (suboption == 0) begin
			  nsuboption = suboption;
			  noption = option;
			  if (but_down) begin
					if (option == 0)
						 noption = 2'(num_option) - 2'd1;
					else
						 noption = option - 2'd1;
			  end else if (but_up) begin
					if (option == num_option - 1)
						 noption = 0;
					else
						 noption = option + 2'd1;
			  end else if (but_sel & option == 1) begin
				nsuboption = 1;
			  end // else if (but_sel & option == 1)
			end else begin
				nsuboption = suboption;
				noption = option;
				if (but_down) begin
					if (suboption == 3)
						nsuboption = 1;
					else 
						nsuboption = suboption + 2'd1;
				end else if (but_up) begin
					if (suboption == 1)
						nsuboption = 3;
					else
						nsuboption = suboption - 2'd1;
				end else if (but_sel) begin
					if (suboption == 3)
						nsuboption = 0;
				end // else if(but_sel)
			end // else

        // Game Start Logic
		  if (playing) begin
				game_start_temp = 0;
		  end else begin
			   game_start_temp = but_sel && option == start_game_option;
		  end // else
		  
		  // soundOn and Anim Logic
		nsoundOn = soundOn;
		nanim = anim;
		if (~playing & suboption == 1 & but_sel) begin
			nsoundOn = ~soundOn;
		end // if(~playing & suboption == 1 & but_sel)
		
		if (~playing & suboption == 2 & but_sel) begin
			nanim = ~anim;
		end // if(~playing & suboption == 2 & but_sel)
		
    end // always_comb

	 // Updates the Options
    always_ff @(posedge clk) begin
        if (reset) begin
            option <= option;
				suboption <= suboption;
				soundOn <= 0;
				anim <= 0;
        end else begin
            option <= noption;
				suboption <= nsuboption;
				soundOn <= nsoundOn;
				anim <= nanim;
        end // else
    end // always_ff

	 initial begin
		anim = 1;
		soundOn = 1;
		option = 0;
		suboption = 0;
	 end // initial
	 
    // Render section
    always_comb begin
		
		if (option == 0) begin
			pointer_dy = base_pointer_dy;
			pointer_dx = 480;
		end else if (suboption == 0) begin
			pointer_dy = base_pointer_dy + 11'(50);
			pointer_dx = 480;
		end else begin
			pointer_dx = 250;
			pointer_dy = opt1_dy + 11'(30 * (suboption - 1));
		end // else
		
		// Sound Logic
		if (soundOn)
			opt1_pix_avail = on1_pixel != 0;
		else
			opt1_pix_avail = off1_pixel != 0;
			
		if (anim)
			opt2_pix_avail = on2_pixel != 0;
		else
			opt2_pix_avail = off2_pixel != 0;
		  
		  // RGB output logic
		  // Pointer has first priority
		 if (pointer_write && (pointer_pixel != 0)) begin
			 r = {pointer_pixel[7:0]};
			 g = {pointer_pixel[15:8]};
			 b = {pointer_pixel[23:16]};
		 end else if (back_write) begin
			 r = {back_pixel[7:0]};
			 g = {back_pixel[15:8]};
			 b = {back_pixel[23:16]};
		 end else if (opt1_write & opt1_pix_avail) begin
			if (soundOn) begin
				r = on1_pixel[7:0];
				g = on1_pixel[15:8];
				b = on1_pixel[23:16];
			end else begin
				r = off1_pixel[7:0];
				g = off1_pixel[15:8];
				b = off1_pixel[23:16];
			end // else
		 end else if (opt2_write & opt2_pix_avail) begin
			if (anim) begin
				r = on2_pixel[7:0];
				g = on2_pixel[15:8];
				b = on2_pixel[23:16];
			end else begin
				r = off2_pixel[7:0];
				g = off2_pixel[15:8];
				b = off2_pixel[23:16];
			end // else
		 end else if (option_write) begin
			r = option_pixel[7:0];
			g = option_pixel[15:8];
			b = option_pixel[23:16];
		 end else begin
			 r = 0;
			 g = 0;
			 b = 0;
		 end // else
		 
        // Background Image
        if (back_dx <= x && (back_width + back_dx) > x && back_dy <= y && (back_dy + back_height) > y) begin
            nback_write = 1;
        end else begin
				nback_write = 0;
		  end // else
		  
        // Pointer Image
        if (pointer_dx <= x && (pointer_width + pointer_dx) > x && pointer_dy <= y && (pointer_dy + pointer_height) > y) begin
            npointer_write = 1;
        end else begin
				npointer_write = 0;
		  end // else
		  
		  // Option Image
        if (option_dx <= x && (option_width + option_dx) > x && option_dy <= y && (option_dy + option_height) > y) begin
            noption_write = 1;
        end else begin
				noption_write = 0;
		  end // else
		  
		  // Opt1 Image
        if (opt1_dx <= x && (opt_width + opt1_dx) > x && opt1_dy <= y && (opt1_dy + opt_height) > y) begin
            nopt1_write = 1;
        end else begin
				nopt1_write = 0;
		  end // else
		  
		  // Opt2 Image
        if (opt2_dx <= x && (opt_width + opt2_dx) > x && opt2_dy <= y && (opt2_dy + opt_height) > y) begin
            nopt2_write = 1;
        end else begin
				nopt2_write = 0;
		  end // else
		  
    end

    always_ff @(posedge clk) begin
		 back_write <= nback_write;
		 pointer_write <= npointer_write;
		 option_write <= noption_write;
		 opt1_write <= nopt1_write;
		 opt2_write <= nopt2_write;
    end // always_ff

endmodule // menu

/* testbench for menu */
module menu_testbench();

   logic clk, reset, playing;
   logic but_up, but_down, but_sel;
   logic [10:0] x;
	logic [10:0] y;
   logic [7:0] r, g, b;
   logic game_start;
	logic soundOn, anim;
	
	menu test (.*);
	
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
		but_up <= 0;
		but_down <= 0;
		but_sel <= 0;
		playing <= 0;
		x <= 0;
		y <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		
		// Change options
		but_up <= 1;
		@(posedge clk);
		but_up <= 0;
		@(posedge clk);
		
		// Change options
		but_up <= 1;
		@(posedge clk);
		but_up <= 0;
		@(posedge clk);
		
		// Enters game
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		@(posedge clk);
		but_down <= 1;
		@(posedge clk);
		but_down <= 0;
		@(posedge clk);
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		
		// Toggle options
		@(posedge clk);
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		@(posedge clk);
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		@(posedge clk);
		but_down <= 1;
		@(posedge clk);
		but_down <= 0;
		
		// Toggle options
		@(posedge clk);
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		@(posedge clk);
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		
		// Go back to parent menu
		@(posedge clk);
		but_down <= 1;
		@(posedge clk);
		but_down <= 0;
		but_sel <= 1;
		@(posedge clk);
		but_sel <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end // initial

endmodule // menu_testbench