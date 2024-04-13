module MACUnit(
    input wire clk,
    input wire [8:0] A,
    input wire [8:0] B,
    output wire [8:0] C,
    output reg [8:0] Aout
    );
    wire [8:0] BxC;
    wire [8:0] A_BxC;

    Multiplier m1(.in1(A), .in2(C), .out(BxC)); //Implement clk instead of continuous?
    Adder a1(.clk(clk), .A(A), .B(BxC), .out(A_BxC));

    always @(posedge clk) begin
        //Assign to output
        Aout = A_BxC;
    end

endmodule

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
    //Zero wire
    assign zero = 0;

    //M1_out = a00 * b00 + a01 * b10 + a02 * b20
    reg [7:0] numM1_0;
    MACUnit M1_0(.clk(clk), .A(zero), .B(a00), .C(b00), .out(numM1_0));
    reg [7:0] numM1_1;
    MACUnit M1_1(.clk(clk), .A(numM1_0), .B(a01), .C(b10), .out(numM1_1));
    reg [7:0] numM1_2;
    MACUnit M1_2(.clk(clk), .A(numM1_1), .B(a02), .C(b20), .out(numM1_2));
    
    //M2_out = a00 * b01 + a01 * b11 + a02 * b21
    reg [7:0] numM2_0;
    MACUnit M2_0(.clk(clk), .A(zero), .B(a00), .C(b01), .out(numM2_0));
    reg [7:0] numM2_1;
    MACUnit M2_1(.clk(clk), .A(numM2_0), .B(a01), .C(b11), .out(numM2_1));
    reg [7:0] numM2_2;
    MACUnit M2_2(.clk(clk), .A(numM2_1), .B(a02), .C(b21), .out(numM2_2));
    
    //M3_out = a00 * b02 + a01 * b12 + a02 * b22
    reg [7:0] numM3_0;
    MACUnit M3_0(.clk(clk), .A(zero), .B(a00), .C(b02), .out(numM3_0));
    reg [7:0] numM3_1;
    MACUnit M3_1(.clk(clk), .A(numM3_0), .B(a01), .C(b12), .out(numM3_1));
    reg [7:0] numM3_2;
    MACUnit M3_2(.clk(clk), .A(numM3_1), .B(a02), .C(b22), .out(numM3_2));
    
    //M4_out = a10 * b00 + a11 * b10 + a12 * b20
    reg [7:0] numM4_0;
    MACUnit M4_0(.clk(clk), .A(zero), .B(a10), .C(b00), .out(numM4_0));
    reg [7:0] numM4_1;
    MACUnit M4_1(.clk(clk), .A(numM4_0), .B(a11), .C(b10), .out(numM4_1));
    reg [7:0] numM4_2;
    MACUnit M4_2(.clk(clk), .A(numM4_1), .B(a12), .C(b20), .out(numM4_2));
    
    //M5_out = a10 * b01 + a11 * b11 + a12 * b21
    reg [7:0] numM5_0;
    MACUnit M5_0(.clk(clk), .A(zero), .B(a10), .C(b01), .out(numM5_0));
    reg [7:0] numM5_1;
    MACUnit M5_1(.clk(clk), .A(numM5_0), .B(a11), .C(b11), .out(numM5_1));
    reg [7:0] numM5_2;
    MACUnit M5_2(.clk(clk), .A(numM5_1), .B(a12), .C(b21), .out(numM5_2));
    
    //M6_out = a10 * b02 + a11 * b12 + a12 * b22
    reg [7:0] numM6_0;
    MACUnit M6_0(.clk(clk), .A(zero), .B(a10), .C(b02), .out(numM6_0));
    reg [7:0] numM6_1;
    MACUnit M6_1(.clk(clk), .A(numM6_0), .B(a11), .C(b12), .out(numM6_1));
    reg [7:0] numM6_2;
    MACUnit M6_2(.clk(clk), .A(numM6_1), .B(a12), .C(b22), .out(numM6_2));
    
    //M7_out = a20 * b00 + a21 * b10 + a22 * b20
    reg [7:0] numM7_0;
    MACUnit M7_0(.clk(clk), .A(zero), .B(a20), .C(b00), .out(numM7_0));
    reg [7:0] numM7_1;
    MACUnit M7_1(.clk(clk), .A(numM7_0), .B(a21), .C(b10), .out(numM7_1));
    reg [7:0] numM7_2;
    MACUnit M7_2(.clk(clk), .A(numM7_1), .B(a22), .C(b20), .out(numM7_2));
    
    //M8_out = a20 * b01 + a21 * b11 + a22 * b21
    reg [7:0] numM8_0;
    MACUnit M8_0(.clk(clk), .A(zero), .B(a20), .C(b01), .out(numM8_0));
    reg [7:0] numM8_1;
    MACUnit M8_1(.clk(clk), .A(numM8_0), .B(a21), .C(b11), .out(numM8_1));
    reg [7:0] numM8_2;
    MACUnit M8_2(.clk(clk), .A(numM8_1), .B(a22), .C(b21), .out(numM8_2));
    
    //M9_out = a20 * b02 + a21 * b12 + a22 * b22
    reg [7:0] numM9_0;
    MACUnit M9_0(.clk(clk), .A(zero), .B(a20), .C(b02), .out(numM9_0));
    reg [7:0] numM9_1;
    MACUnit M9_1(.clk(clk), .A(numM9_0), .B(a21), .C(b12), .out(numM9_1));
    reg [7:0] numM9_2;
    MACUnit M9_2(.clk(clk), .A(numM9_1), .B(a22), .C(b22), .out(numM9_2));

    always @(posedge clk) begin
        //Update result
        M1_out = numM1_2;
        M2_out = numM2_2;
        M3_out = numM3_2;
        M4_out = numM4_2;
        M5_out = numM5_2;
        M6_out = numM6_2;
        M7_out = numM7_2;
        M8_out = numM8_2;
        M9_out = numM9_2;
    end
endmodule