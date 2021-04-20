`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:19:22 01/25/2019
// Design Name:   fsm_traffic
// Module Name:   C:/Users/CS152B/Documents/pork/lab2/fsm_traffic_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm_traffic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fsm_traffic_tb;

	// Inputs
	reg clock;
	reg walk;
	reg sensor;
	reg rst;

	// Outputs
	wire [2:0] main_light;
	wire [2:0] side_light;
	wire walk_light;

	// Instantiate the Unit Under Test (UUT)
	fsm_traffic uut (
		.clock(clock), 
		.walk(walk), 
		.sensor(sensor), 
		.rst(rst), 
		.main_light(main_light), 
		.side_light(side_light), 
		.walk_light(walk_light)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		walk = 0;
		sensor = 0;
		rst = 1;
		#100
		rst = 0;
		
		#1000
		
		rst = 1;
		#100
		rst = 0;
		
		
		walk = 1;

		#1000

		rst = 1;
		#100
		rst = 0;

		sensor = 1;
		
		rst = 1;
		#100
		rst = 0;
		
		walk = 0;

	end
	
	always begin
	#5 clock = ~clock; // Toggle clock every 5 ticks
	end
      
endmodule

