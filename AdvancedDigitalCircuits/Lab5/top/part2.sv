/* This top-level module takes input from the Mic-in (pink) line on the
 * DE1_SoC board, and outputs sound on the line-out (green) line using a
 * Finite Impulse Response Filter of width 8 (samples)
 * 
 * Inputs:
 *   CLOCK_50 			- FPGA on-board 50 MHz clock
 *   CLOCK2_50  		- FPGA on-board 2nd 50 MHz clock
 *   KEY 				- 4-bits for the FPGA on-board pyhsical key switches. 
 *                  		Each KEY[i] is FALSE when pressed, TRUE otherwise.
 *								KEY[0] is used as a synchronous reset signal. Active when button is pressed.
 *   FPGA_I2C_SCLK 	- FPGA I2C communication protocol clock
 *   FPGA_I2C_SDAT  	- FPGA I2C communication protocol data
 *   AUD_XCK 			- Audio CODEC data
 *   AUD_DACLRCK 		- Audio CODEC data
 *   AUD_ADCLRCK 		- Audio CODEC data
 *   AUD_BCLK 			- Audio CODEC data
 *   AUD_ADCDAT 		- Audio CODEC data
 *
 * Output:
 *   AUD_DACDAT 		- output Audio CODEC data
 */
module part2 (
	CLOCK_50, 
	CLOCK2_50, 
	KEY, 
	FPGA_I2C_SCLK, 
	FPGA_I2C_SDAT, 
	AUD_XCK, 
	AUD_DACLRCK, 
	AUD_ADCLRCK, 
	AUD_BCLK, 
	AUD_ADCDAT, 
	AUD_DACDAT
);
	// external signals
	input logic CLOCK_50, CLOCK2_50;
	input logic [3:0] KEY;
	output logic FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	output logic AUD_XCK;
	input logic AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input logic AUD_ADCDAT;
	output logic AUD_DACDAT;
	
	// internal signals
	logic read_ready, write_ready, read, write;
	logic [23:0] readdata_left, readdata_right;
	logic [23:0] writedata_left, writedata_right;
	logic reset;
	
	// make reset be TRUE when KEY[0] is pressed
	assign reset = ~KEY[0];
	
	// circuit for task 2
	assign read =  read_ready;
	assign write = write_ready;
	
	FIR_8 left_fir (.clk(CLOCK_50), .reset(reset), .din(readdata_left), .dout(writedata_left), .en(read_ready));
	FIR_8 right_fir (.clk(CLOCK_50), .reset(reset), .din(readdata_right), .dout(writedata_right), .en(read_ready));

	clock_generator my_clock_gen(
		CLOCK2_50,
		reset,
		AUD_XCK
	);

	audio_and_video_config cfg(
		CLOCK_50,
		reset,
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
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

endmodule // part2


