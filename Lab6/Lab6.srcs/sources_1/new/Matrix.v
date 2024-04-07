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
                input wire a00, 
                input wire a01, 
                input wire a02, 
                input wire a10, 
                input wire a11, 
                input wire a12, 
                input wire a20, 
                input wire a21, 
                input wire a22, 
                input wire b00, 
                input wire b01, 
                input wire b02, 
                input wire b10, 
                input wire b11, 
                input wire b12, 
                input wire b20, 
                input wire b21, 
                input wire b22,
                //make sure the above wires/ports are identicaly
                
                //You can choose not to have below wires/ports in your design
                output reg M1_out, 
                output reg M2_out, 
                output reg M3_out, 
                output reg M4_out, 
                output reg M5_out, 
                output reg M6_out, 
                output reg M7_out, 
                output reg M8_out, 
                output reg M9_out, 
                output reg done
    );
endmodule
