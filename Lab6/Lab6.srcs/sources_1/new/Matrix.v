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
                output reg [7:0] M1_out, 
                output reg [7:0] M2_out, 
                output reg [7:0] M3_out, 
                output reg [7:0] M4_out, 
                output reg [7:0] M5_out, 
                output reg [7:0] M6_out, 
                output reg [7:0] M7_out, 
                output reg [7:0] M8_out, 
                output reg [7:0] M9_out, 
                output reg done
    );
    
    
endmodule
