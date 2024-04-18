`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2024 11:19:01 AM
// Design Name: 
// Module Name: Addition_Multiplication_tb
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


module Addition_Multiplication_tb();
    reg [7:0] A;
    reg [7:0] B;
    
    wire [7:0] Add_out, Mult_out;
    
    initial begin
        //A = 8'b00100000;
        //B = 8'b00110000;
        
        //A = 8'b00110000;
        //B = 8'b10111000;
        
        A = 8'b00110010;
        B = 8'b01000010;
     
    end
    
    Adder add(A, B, Add_out);
    Multiplier mult(A, B, Mult_out);
    
endmodule