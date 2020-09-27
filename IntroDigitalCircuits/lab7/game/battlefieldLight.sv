// tug of war battlefield lights
// lightOn: The LED related to this battlefieldLight should be ON/True if either:
//				- The left neighbor was previously ON and the right player advanced
//				- The right neighbor was previously ON and the left player advanced
// initialState: True if the LED related to this battlefieldLight should be initially ON, otherwise off. 
module battlefieldLight(reset, clk, neighborLeft, neighborRight, lightOn, leftButtonPressed, rightButtonPressed, initialState);
	input logic reset, clk, leftButtonPressed, rightButtonPressed, neighborLeft, neighborRight, initialState;
	output logic lightOn;
	
	parameter logic off = 0, on = 1;
	logic ps, ns;
	
	always_comb begin
		case(ps)
			off: begin
				if((neighborRight && ~rightButtonPressed && leftButtonPressed) || (neighborLeft && rightButtonPressed && ~leftButtonPressed)) begin
					ns = on;
				end
				else ns = off;
			end
			
			on: begin
				if((leftButtonPressed && ~rightButtonPressed) || (~leftButtonPressed && rightButtonPressed))
					ns = off;
				else 
					ns = on;
			end
			
			default: begin
				ns = initialState;
			end
		endcase
	end
	
	assign lightOn = (ps == on);
	
	always_ff @(posedge clk) begin
		if(reset && initialState) ps <= on;
		else if(reset && ~initialState) ps <= off;
		else ps <= ns;
	end
	
endmodule

module battlefieldLight_testbench();
	logic reset, clk, leftButtonPressed, rightButtonPressed, neighborLeft, neighborRight, initialState;
	logic lightOn;
	
	battlefieldLight dut(.reset, .clk, .leftButtonPressed, .rightButtonPressed, .neighborLeft, .neighborRight, .initialState, .lightOn);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever begin
			#(CLOCK_PERIOD / 2);
			clk <= ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		leftButtonPressed <= 0;
		rightButtonPressed <= 0;
		neighborLeft <= 0;
		neighborRight <= 0;
		initialState <= 0;
												@(posedge clk);
		reset <= 0;
												@(posedge clk);
		leftButtonPressed <= 1;			@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
		leftButtonPressed <= 0;			@(posedge clk);
		rightButtonPressed <= 0;		@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		neighborLeft <= 1;
												@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
		leftButtonPressed <= 1;			@(posedge clk);
		rightButtonPressed <= 0;		@(posedge clk);
		leftButtonPressed <= 0;
		neighborLeft <= 0;				@(posedge clk);
		
		neighborRight <= 1;
												@(posedge clk);
		leftButtonPressed <= 1;			@(posedge clk);
		rightButtonPressed <= 1;		@(posedge clk);
		leftButtonPressed <= 0;			@(posedge clk);
		rightButtonPressed <= 0;
		neighborRight <= 0;				@(posedge clk);
												@(posedge clk);
		
		$stop;
												
	end
	
endmodule