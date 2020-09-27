/* Connects the data from the CODEC interface so that the mic-in line is 
 * output on the line-out line
 * 
 * Inputs:
 *   	read_ready				- 1-bit signal. TRUE when the interface has a new sample from mic-in
 *		write_ready				- 1-bit signal. TRUE when the interface can take a new sample to line-out
 *		readdata_left			- 24-bit audio signal from mic-in (left channel)
 *		readdata_right			- 24-bit audio signal from mic-in (right channel)
 *
 * Outputs:
 *   	writedata_left			- 24-bit audio signal to line-out (left channel)
 *		writedata_right		- 24-but audio signal to line-out (right channel)
 */
module connection_circuit(writedata_left, writedata_right, readdata_left, readdata_right, read, write, read_ready, write_ready);
	input logic read_ready, write_ready; 
	input logic [23:0] readdata_left, readdata_right;
	
	output logic read, write;
	output logic [23:0] writedata_left, writedata_right;
	
	// connect outputs 
	assign writedata_left = readdata_left;
	assign writedata_right = readdata_right;
	assign read =  read_ready;
	assign write = write_ready;
	
endmodule // connection_circuit

/* testbench for connection_circuit */
module connection_circuit_testbench();
	logic read_ready, write_ready; 
	logic [23:0] readdata_left, readdata_right;
	logic read, write;
	logic [23:0] writedata_left, writedata_right;
	
	parameter WAIT_TIME = 100;
	parameter SMALL_TIME = 1;
	
	connection_circuit dut (.*);
	
	// provide inputs
	initial begin
		{read_ready, write_ready} = 2'b0;
		{readdata_left, readdata_right} = '0;
		#(WAIT_TIME);
		
		// test read
		read_ready = 1'b0; #(SMALL_TIME);
		assert(read == read_ready) $display("read_ready == read: TRUE");
		else $error("read_ready is not equal to read");
		#(WAIT_TIME);
		
		read_ready = 1'b1; #(SMALL_TIME);
		assert(read == read_ready) $display("read_ready == read: TRUE");
		else $error("read_ready is not equal to read");
		#(WAIT_TIME);
		
		// test write
		write_ready = 1'b0; #(SMALL_TIME);
		assert(write == write_ready) $display("write_ready == write: TRUE");
		else $error("write_ready is not equal to write");
		#(WAIT_TIME);
		
		write_ready = 1'b1; #(SMALL_TIME);
		assert(write == write_ready) $display("write_ready == write: TRUE");
		else $error("write_ready is not equal to write");
		#(WAIT_TIME);
		
		// test readdata_left and readdata_right
		for(integer i = 0; i < 5; i++) begin
			readdata_left = 23'(i);
			readdata_right = 23'(i * i); #(SMALL_TIME);
			
			assert(readdata_left == writedata_left) $display("readdata_left == writedata_left: TRUE");
			else $error("readdata_left is not equal to writedata_left");
			
			assert(readdata_right == writedata_right) $display("readdata_right == writedata_right: TRUE");
			else $error("readdata_right is not equal to writedata_right");
			
			#(WAIT_TIME);
		end // for over i
		
		$stop;
	end // initial
endmodule // connection_circuit_testbench
