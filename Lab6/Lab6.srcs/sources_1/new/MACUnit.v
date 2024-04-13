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
    input wire [7:0] A, B,
    output reg [7:0] pass_A, pass_B,
    output reg [7:0] C //Final output
    );
    
    initial begin C = 0; pass_A = 0; pass_B = 0; end
    
    wire [7:0] AxB;
    wire [7:0] C_next;
    Multiplier m1(.in1(A), .in2(B), .out(AxB));
    Adder a1(.A(C), .B(AxB), .out(C_next));
    
    always @(posedge clk) begin
        C = C_next;
        pass_A = A;
        pass_B = B;
    end
    
endmodule
