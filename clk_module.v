`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:58 01/22/2019 
// Design Name: 
// Module Name:    clk_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_1sec (
clock , // Clock input of the design
rst , // active high, synchronous rst input
clk_out 
); // End of port list
//-------------IO Ports-----------------------------

input clock ;
input rst ;
output clk_out;

//-------------Input ports Data Type-------------------
// By rule all the input ports should be wires
wire clock ;
wire rst ;

//-------------Output Ports Data Type------------------
// Output port can be a storage element (reg) or a wire
reg clk_out;
reg [31:0] clk_div ;

// We trigger the below block
// with respect to positive edge of the clock.
always @ (posedge clock)
begin
    // At every rising edge of clock we check if rst is active
    // If active, we load the counter output with 4'b0000
    if (rst === 1'b1) begin
        clk_out <= #1 1'b0;
        clk_div <= #1 32'd0;
    end
    else begin
    // we increment the counter if rst is zero
    clk_div <= #1 clk_div + 1;
    end
    
    if (clk_div === 32'd50000000)
    begin
    clk_out <= #1 ~clk_out;
    clk_div <= #1 32'd0;
    end
end // End of Block COUNTER
endmodule // End of Module counter
