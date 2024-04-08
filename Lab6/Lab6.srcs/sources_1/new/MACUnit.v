`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2024 06:34:32 PM
// Design Name: 
// Module Name: MACUnit
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


module MACUnit(
    input wire clk,
    input wire [8:0] A,
    input wire [8:0] B,
    input wire [8:0] C,
    output reg [8:0] out
    );
    wire [8:0] BxC;
    
    Multiplier m1(.in1(A), .in2(C), .out(BxC));
    
    always @(posedge clk) begin  
        //Check for special cases (zero, infinity, NaN)
    end
    
endmodule
