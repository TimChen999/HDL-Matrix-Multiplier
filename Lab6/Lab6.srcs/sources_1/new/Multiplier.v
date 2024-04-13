`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2024 05:04:45 PM
// Design Name: 
// Module Name: Multiplier
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

//Multiply 2 numbers 
//1 bit for the sign, 3 bits for the biased exponent (which are biased by 3) and 4 bits for the mantissa (fraction) parts with a leading 1.
module Multiplier(
    input wire [7:0] in1,
    input wire [7:0] in2,
    output reg [7:0] out
    );
    
    //Store variables
    reg [4:0] exponent;
    reg [9:0] fraction;
    reg fractionOverflow;
    initial begin exponent = 0; fraction = 0; fractionOverflow = 0; end
    
    always @(*) begin
        //Sign bit
        out[7] = in1[7] ^ in2[7];
        
        //Fraction bits
            fraction = {1'b1, in1[3:0]} * {1'b1, in2[3:0]}; //Multiply fractions
            //This gives an 10 bit result, with 2 fraction and 8 decimal bits, 
            //Range of result: 1 (1.0000 * 1.0000 = 01.0000_0000 (1) to 1.1111 * 1.1111 = 11.1100_0001 (3.754))
                
            //Handle overflow (2 fraction bits >= 2, then divide by 2)
            if(fraction > 10'b10_0000_0000)begin
                fraction = fraction / 2;
                fractionOverflow = 1;
            end else begin fractionOverflow = 0; end
            
            //Set output: For decimal bits, take the first 4 decimal bits of combined solution
            out[3:0] = fraction[7:4];
        
        //Exponent bits
            exponent = in1[6:4] - in2[6:4] - 3 + fractionOverflow; //Add exponents
                
            //Handle overflow (>7, then set to 7, <0, then set to 0)
            if(exponent > 7) begin
                exponent = 7; end
            else if(exponent < 0) begin
                exponent = 0; end
                    
            //Set output        
            out[6:4] = exponent;
        
    end
endmodule
