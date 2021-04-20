`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:47 01/25/2019
// Design Name:   fsm_traffic
// Module Name:   C:/Users/CS152B/Documents/pork/lab2/state_to_light_tb.v
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

module state_to_light_tb;

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
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

