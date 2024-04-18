`timescale 1ns / 1ps

//Multiply 2 numbers 
//1 bit for the sign, 3 bits for the biased exponent (which are biased by 3) and 4 bits for the mantissa (fraction) parts with a leading 1.
module Multiplier(
    input wire [7:0] in1,
    input wire [7:0] in2,
    output wire [7:0] out
    );
    
    //Sign bit
    assign out[7] = in1[7] ^ in2[7];
    
    //Fraction bits
    wire[4:0] frac1;
    wire[4:0] frac2;
    assign frac1 = {1'b1, in1[3:0]};
    assign frac2 = {1'b1, in2[3:0]};
    
    wire frac1_exp = frac1 - 3;
    wire frac2_exp = frac2 - 3;

    
    //Sign Bit (1 bit)   
    wire out_sign = frac1[7] ^ frac2[7];
    
    //Multiply fraction
    wire[9:0] fracOut; //10 bits total, MST is overflow bit, bit 8 should be leading 1 if no overflow, 7:0 are fraction
    assign fracOut = frac1 * frac2;
    
    //Final significand has 2 cases
    //Case 1: there is no 1 in the MSB, -> take the [7:4] bits
    //Case 2: there is a 1 in the MSB, -> take the [8:5] bits
    wire [3:0] out_significand = fracOut[9] ? fracOut[8:5]: fracOut[7:4];
    
     //Adding Exponents
    wire[2:0] out_exponent = frac1_exp + frac2_exp + 3 + fracOut[9];
    
    assign out = ((in1 == 0) || (in2 == 0)) ? 8'b00000000: {out_sign,out_exponent,out_significand};
    
//    //Assgin overflow
//    wire overflow;
//    assign overflow = fracOut[9]; //Fraction must have gone over alloted bits if above 5
    
//    //If overflow, divide fraction by half and increase exponent by 1
//    wire [9:0] fracOverflow;
//    assign fracOverflow = (overflow) ? fracOut >> 1 : fracOut; //overflow condition
//    assign out[3:0] = fracOverflow[7:4]; //Truncate fraction bits and add to output
    
    //Calculate exponent, if overflow, add an additional 1 
//    wire [3:0] exponent;
//    assign exponent = in1[6:4] - in2[6:4] - 3 + overflow;
//    assign out[6:4] = exponent;
    
    /*
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
    */
endmodule