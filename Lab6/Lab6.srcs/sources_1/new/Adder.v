`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2024 08:03:55 PM
// Design Name: 
// Module Name: Adder
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

//Add 2 8 bit floating point numbers (
`timescale 1ns / 1ps


module Adder(
    input clk, //not needed
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [7:0] out
    );
    
    wire csign;
    wire [7:0] big;
    wire [10:0] big_num;

    reg shiftNum;
    wire [7:0] smol;
    wire [9:0] smol_num;
    wire  expDiff;
    wire exp;
    wire [10:0] sum;
    
    wire [3:0] cfrac;
    wire [2:0]  cexp;

    //extra 
    integer i;
    reg leftmost_bit_pos;//check
    //

    initial begin
    end
    assign big = A[6:0] >= B[6:0] ? A : B; 
    assign smol = A[6:0] < B[6:0] ? A : B;
    assign csign = big[7];
    
    //fraction part
    assign big_num = {1'b1, big[3:0],5'b00000};
    assign smol_num = {1'b1, smol[3:0],5'b00000};
    assign expDiff = big[6:4] - smol[6:4]; //exponennt diff
    assign smol_num = smol_num >> expDiff; //shift by the difference
    //conisder tcaes when same sign vs opposite sign
    assign sum = (big[7] != smol[7]) ? big_num + smol_num : big_num - smol_num;
    assign exp = big[6:4];
    //assign the fraction bits with large if states
    //consider when both fractions are the 00000 and the exponents are the same = answer should be 00000
    assign cfrac = (A[6:0] == B[6:0] == 0) ? 4'b0000 :  sum[10] == 1 ? sum[9:6] : sum[9] == 1 ? sum[8:5] : sum[8] == 1 ? sum[7:4] : sum[7] == 1 ? sum[6:3] :sum[6] == 1 ? sum[5:2] : sum[5] == 1 ? sum[4:1]: sum[3:0];
    //assign the exponent +1 ifc[9] is -0 fc[8] sets exp to exp  - 1then f[7] exp -1....
    assign cexp =  (A[6:0] == B[6:0] == 0) ? 3'b000 : sum[10] == 1 ? exp : sum[9] == 1 ? exp - 1 : sum[8] == 1 ? exp - 2 : sum[7] == 1 ? exp - 3 :sum[6] == 1 ? exp - 4 : sum[5] == 1 ? exp - 5 : exp - 6;
    
    assign out =  {csign, cexp, cfrac}; //bit width: 1_3_4 = 8 bits in total
endmodule
