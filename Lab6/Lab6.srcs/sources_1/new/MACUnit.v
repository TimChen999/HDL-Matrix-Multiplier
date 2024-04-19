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
    input start,
    input wire [7:0] A, 
    input wire [7:0] B,
    output reg [7:0] pass_A, 
    output reg [7:0] pass_B,
    output reg [7:0] C //Final output
    );
    
    initial begin C = 0; pass_A = 0; pass_B = 0; end
    
    wire [7:0] AxB;
    wire [7:0] C_next;
    Multiplier m1(A, B, AxB);
    Adder a1(C, AxB, C_next);
    
    always @(negedge clk) begin
        if(start)
            C = C_next;
            pass_A <= A;
            pass_B <= B;
    end
    
endmodule
