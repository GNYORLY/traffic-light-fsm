`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:02 01/24/2019 
// Design Name: 
// Module Name:    state_to_light 
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
module state_to_light(clk, state, main_light, side_light, walk_light);

input[2:0] state;
input clk;
output reg[2:0] main_light, side_light;
output reg walk_light;


// 000 m-g, s-r, 6sec --> 001 [sensor-1] / 010 [sensor-0] {counter -> 6}
// 001 m-g, s-r, 3sec --> 011 {counter ->3}
// 010 m-g, s-r, 6sec --> 011 {counter -> 6}

// 011 m-y, s-r, 2sec --> 100 [walk-0] / 111 [walk-1] {counter -> 2}

// 100 m-r, s-g, 6sec --> 101 [sensor-1 ]/ 110 [sensor-0] {counter -> 6}
// 101 m-r, s-g, 3sec --> 110 {counter ->3}

// 110 m-r, s-y, 2sec --> 000 {counter ->2}

// 111 m-r, s-r, w-o, 3sec --> 100 {counter -> 3}

// green: 001
// yellow: 010
// red: 100

always @ (posedge clk) begin
    case (state)
        3'b000, 3'b001, 3'b010:     // m-g, s-r
        begin       
            main_light <= 3'b001;
            side_light <= 3'b100;
            walk_light <= 1'b0;
        end
        
        3'b011:      // m-y, s-r
        begin   
            main_light <= 3'b010;
            side_light <= 3'b100;
            walk_light <= 1'b0;
        end
        
        3'b100, 3'b101:     // m-r, s-g
        begin
            main_light <= 3'b100;
            side_light <= 3'b001;
            walk_light <= 1'b0;
        end
        
        3'b110:     // m-r, s-y
        begin
            main_light <= 3'b100;
            side_light <= 3'b010;
            walk_light <= 1'b0; 
        end
        
        3'b111:     // m-r, s-r, w-o
        begin
            main_light <= 3'b100;
            side_light <= 3'b100;
            walk_light <= 1'b1;
        end
    endcase
end

endmodule
