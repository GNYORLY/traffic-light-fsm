`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:31 01/22/2019 
// Design Name: 
// Module Name:    fsm_traffic 
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
module fsm_traffic(clock, walk, sensor, rst, main_light, side_light, walk_light); //remove counter

input clock, walk, sensor, rst;
output[2:0] main_light, side_light;
output walk_light;

wire btn_walk, btn_rst;

wire clk;
reg[2:0] counter;
reg walk_reg;

reg[2:0] state;
// 000 m-g, s-r, 6sec --> 001 [sensor-1] / 010 [sensor-0] {counter -> 6}

// 001 m-g, s-r, 3sec --> 011 {counter ->3}
// 010 m-g, s-r, 6sec --> 011 {counter -> 6}

// 011 m-y, s-r, 2sec --> 100 [walk-0] / 111 [walk-1] {counter -> 2}
// 111 m-r, s-r, w-o, 3sec --> 100 {counter -> 3}
// 100 m-r, s-g, 6sec --> 101 [sensor-1 ]/ 110 [sensor-0] {counter -> 6}

// 101 m-r, s-g, 3sec --> 110 {counter ->3}
// 110 m-r, s-y, 2sec --> 000 {counter ->2}  

debouncer d1(.clk(clock), .button(walk), .o_b(btn_walk));
debouncer d2(.clk(clock), .button(rst), .o_b(btn_rst));

clk_1sec clk_output(.clock(clock), .rst(btn_rst), .clk_out(clk));
state_to_light stl(.clk(clk), .state(state), .main_light(main_light), .side_light(side_light), .walk_light(walk_light)); 

// critical value of seconds: 2, 3, 6
// checking states w/ seconds
// 2: 011, 110
// 3: 001, 101, 111
// 6: 000, 010, 100

always @ (posedge clk or posedge btn_rst or posedge btn_walk) begin
	 
	 if (btn_rst == 1'b1) begin
		  walk_reg <= 0;
        counter <= 3'd0;
        state <= 3'b000;    // set default state
    end
	 else if (btn_walk == 1'b1) begin
		  walk_reg <= 1; 
	 end
    else begin
        case (counter)
        /********************** 
          ****  case 2 sec ****
        ************************/
        3'd2: 
        begin // 3'd2 begin
            case (state)     // changing state: 011, 110; else: increment counter
            3'b011: 
                begin   // 3'b011 begin
                counter <= 3'd1;
                if (walk_reg == 1'b0)
                    state <= 3'b100;
                else 
                    state <= 3'b111;
            end     // 3'b011 end
                
            3'b110:
            begin   // 3'b110 begin
                counter <= 3'd1;
                state <= 3'b000;
            end     // 3'b110 end
            default:
                counter <= counter + 1;
            endcase     // case state end
        end // 3'd2 end
        
        /********************** 
          ****  case 3 sec ****
        ************************/
        3'd3:   // state 011, 110 should never reach here
        begin
            case (state)    // changing state: 001, 101, 111; else: increment counter
            3'b001:
            begin   // 3'b001 begin
                counter <= 3'd1;
                state <= 3'b011;
            end     // 3'b001 end      
                
            3'b101:
            begin   // 3'b101 begin
                counter <= 3'd1;
                state <= 3'b110;
            end     // 3'b101 end
                
            3'b111:
            begin   // 3'b111 begin
                counter <= 3'd1;
					 walk_reg <= 0;
                state <= 3'b100;
            end     // 3'b111 end
                
            default:
                counter <= counter + 1;
            endcase     // case state end
        end // 3'd3 end
        
        /********************** 
          ****  case 6 sec ****
        ************************/
        3'd6:   // state 011, 110, 001, 101, 111 should never reach here
        begin
            case (state)    // changing state: 000, 010, 100
            3'b000: 
            begin       // 3'b000 begin
                counter <= 3'd1;
                if (sensor == 1)
                    state <= 3'b001;
                else
                    state <= 3'b010;
            end // 3'b000 end
            
            3'b010:
            begin   // 3'b010 begin
                counter <= 3'd1;
                state <= 3'b011;
            end     
            
            3'b100:
            begin   // 3'b100 begin
                counter <= 3'd1;
                if (sensor == 1)
                    state <= 3'b101;
                else
                    state <= 3'b110;
            end // 3'b100 end
            endcase // case state end
        end // 3'd6 end
        
        default:   // 0, 1, 4, 5 secs; other values are illegal
            counter <= counter + 1;
        endcase // case counter end
    end
end
endmodule
