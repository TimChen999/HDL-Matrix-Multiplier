`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2024 04:39:26 PM
// Design Name: 
// Module Name: Matrix
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Matrix(
                input wire clk, 
                input wire reset, 
                input wire start, 
                input wire [7:0] a00, 
                input wire [7:0] a01, 
                input wire [7:0] a02, 
                input wire [7:0] a10, 
                input wire [7:0] a11, 
                input wire [7:0] a12, 
                input wire [7:0] a20, 
                input wire [7:0] a21, 
                input wire [7:0] a22, 
                input wire [7:0] b00, 
                input wire [7:0] b01, 
                input wire [7:0] b02, 
                input wire [7:0] b10, 
                input wire [7:0] b11, 
                input wire [7:0] b12, 
                input wire [7:0] b20, 
                input wire [7:0] b21, 
                input wire [7:0] b22,
                //make sure the above wires/ports are identicaly

                //You can choose not to have below wires/ports in your design
                output wire [7:0] M1_out, 
                output wire [7:0] M2_out, 
                output wire [7:0] M3_out, 
                output wire [7:0] M4_out, 
                output wire [7:0] M5_out, 
                output wire [7:0] M6_out, 
                output wire [7:0] M7_out, 
                output wire [7:0] M8_out, 
                output wire [7:0] M9_out, 
                output reg done
    );
   reg[7:0]
   //Inputs
   a0, a1, a2, b0, b1, b2;
   
   wire[7:0]
   //Placeholder 
   p0, p1, p2, p3, p4, p5, 
   
   //Connects 1st row
   c00_01, c01_02, //Right
   c00_10, c01_11, c02_12, //Down
   
   //Connects 2nd row
   c10_11, c11_12,
   c10_20, c11_21, c12_22,
   
   //Connects 3rd row
   c20_21, c21_22;
   
   //Mac 1st row
   MACUnit m00(.clk(clk),   .A(a0),         .B(b0),    .pass_A(c00_01),    .pass_B(c00_10),    .C(M1_out));
   MACUnit m01(.clk(clk),   .A(c00_01),     .B(b1),    .pass_A(c01_02),    .pass_B(c01_11),    .C(M2_out));
   MACUnit m02(.clk(clk),   .A(c01_02),     .B(b2),    .pass_A(p0),        .pass_B(c02_12),    .C(M3_out));

   //Mac 2nd row
   MACUnit m10(.clk(clk),   .A(a1),         .B(c00_10),    .pass_A(c10_11),    .pass_B(c10_20),    .C(M4_out));
   MACUnit m11(.clk(clk),   .A(c10_11),     .B(c01_11),    .pass_A(c11_12),    .pass_B(c11_21),    .C(M5_out));
   MACUnit m12(.clk(clk),   .A(c11_12),     .B(c02_12),    .pass_A(p1),        .pass_B(c12_22),    .C(M6_out));
   
   //Mac 3rd row
   MACUnit m20(.clk(clk),   .A(a2),         .B(c10_20),    .pass_A(c20_21),    .pass_B(p3),    .C(M7_out));
   MACUnit m21(.clk(clk),   .A(c20_21),     .B(c11_21),    .pass_A(c21_22),    .pass_B(p4),    .C(M8_out));
   MACUnit m22(.clk(clk),   .A(c21_22),     .B(c12_22),    .pass_A(p2),        .pass_B(p5),    .C(M9_out));
   
   //State
   reg[4:0] state;
   initial begin state = 0; end
   
   //FSM
   always @(posedge clk) begin
   case(state)
   //Return matrix: 00<-(a00, b00) (inputs)
    0: begin
        a0 = a00;
        a1 = 0;
        a2 = 0;
        b0 = b00;
        b1 = 0;
        b2 = 0;
        state = 1;
    end
    //Return matrix: 00<-(a01, b10) 10<-(a10) 01<-(b01)
    1: begin
        a0 = a01;
        a1 = a10;
        a2 = 0;
        b0 = b10;
        b1 = b01;
        b2 = 0;
        state = 2;
    end
    //Return matrix: 00<-(a02, b20) 10<-(a11) 01<-(b11) 20<-(a20) 02<-(b02)
    2: begin
        a0 = a02;
        a1 = a11;
        a2 = a20;
        b0 = b20;
        b1 = b11;
        b2 = b02;
        state = 3;
    end
    //Return matrix: 10<-(a12) 01<-(b21) 20<-(a21) 02<-(b12)
    3: begin
        a0 = 0;
        a1 = a12;
        a2 = a21;
        b0 = 0;
        b1 = b21;
        b2 = b12;
        state = 4;
    end
    //Return matrix: 20<-(a22) 02<-(b22)
    4: begin
        a0 = 0;
        a1 = 0;
        a2 = a22;
        b0 = 0;
        b1 = 0;
        b2 = b22;
        state = 5;
    end
    //Final state
    5: begin
        a0 = 0;
        a1 = 0;
        a2 = 0;
        b0 = 0;
        b1 = 0;
        b2 = 0;
        done = 1;
        state = 5;
    end
   endcase
   end


endmodule

