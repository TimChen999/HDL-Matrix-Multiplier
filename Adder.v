`timescale 1ns / 1ps


module Adder(
    input clk,
    input wire [8:0] A,
    input wire [8:0] B,
    output reg [8:0] out
    );
    
    reg [8:0] Csign;
    reg [8:0] big;
    reg [10:0] big_num;

    reg shiftNum;
    reg [8:0] smol;
    reg [10:0] smol_num;
    
    reg sum;
    integer leftmost_bit_pos;

    
    always@(posedge clk) begin
        // add floating point numbers
        //1. compare both numbers for sign of C
        if (A[6:0] > B[6:0]) begin
            Csign[7] = A[7];
            big = A;
            smol = B;
        end else begin
            Csign[7] = B[7];
            big = B;
            smol = A;
        end
        //2 concatenate 1 to the end of fractions
        big_num = {1'b1, big[3:0],4'b0000};
        smol_num = {1'b1, smol[3:0],4'b0000};
       //3. Alignment: shift exponents
       if (big[6:0] != smol[6:0]) begin
              //shift small to match the big exponenet value
            smol_num >> 1;
       end 
      //additionout = sum
        sum = big_num + smol_num;
      //Normalize
        //find the leftmost 1 and shift OF SUM
        if (sum & 8'b100000000) begin
            out = sum;
        else begin
      //find the leftmost 1 and shift
            sum << 1;
        end
      end
    
    end
endmodule
