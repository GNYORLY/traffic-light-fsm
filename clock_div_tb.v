`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:37:48 01/25/2019
// Design Name:   clk_1sec
// Module Name:   C:/Users/CS152B/Documents/pork/lab2/clock_div_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_1sec
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_div_tb();
// Declare inputs as regs and outputs as wires
reg clock, rst;
wire clk_out;
// Initialize all variables
initial begin
 $display ("time\t clk reset enable counter");
 $monitor ("%g\t %b %b %b",
 $time, clock, rst, clk_out);
 clock = 1; // initial value of clock
 rst = 0; // initial value of reset
 
 #5 rst = 1; // Assert the reset
 #10 rst = 0; // De-assert the reset

end
// Clock generator
always begin
 #5 clock = ~clock; // Toggle clock every 5 ticks
end
// Connect DUT to test bench
clk_1sec clk_div(
clock,
rst,
clk_out
);
endmodule






