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
    output wire [7:0] out
    );
    //Store output value
    wire[7:0] outVal;
    
    //Sign bit (XOR condition)
    assign outVal[7] = in1[7] ^ in2[7];
    
    //Fraction bits
    wire[4:0] frac1;
    wire[4:0] frac2;
    assign frac1 = {1'b1, in1[3:0]};
    assign frac2 = {1'b1, in2[3:0]};
    
    //Multiply fraction
    wire[9:0] fracOut; //10 bits total, MST is overflow bit, bit 8 should be leading 1 if no overflow, 7:0 are fraction
    assign fracOut = frac1 * frac2;
    
    //Assgin overflow
    wire overflow;
    assign overflow = fracOut[9]; //Fraction must have gone over alloted bits if above 5
    
    //If overflow, divide fraction by half and increase exponent by 1
    wire [9:0] fracOverflow;
    assign fracOverflow = (overflow) ? fracOut >> 1 : fracOut; //overflow condition
    assign outVal[3:0] = fracOverflow[7:4]; //Truncate fraction bits and add to output
    
    //Calculate exponent, if overflow, add an additional 1 
    wire [3:0] exponent, ex1, ex2;
    assign ex1 = in1[6:4]; //1st number exponent
    assign ex2 = in2[6:4]; //2nd number exponent
    assign exponent = ex1 + ex2 - 3 + overflow;
    assign outVal[6:4] = exponent;
    
    //Final output (with zero checking)
    assign out = ((in1 == 0) || (in2 == 0)) ? 8'b00000000: outVal;
    
endmodule
