
module MACUnit(
    input wire clk,
    input  start,
    input wire [7:0] A, 
    input wire [7:0] B,
    output reg [7:0] pass_A, 
    output reg [7:0] pass_B,
    output reg [7:0] C //Final output
    );
    
    initial begin C = 0; pass_A = 0; pass_B = 0; end
    
    wire [7:0] AxB;
    wire [7:0] C_next;
    Multiplier m1(.in1(A), .in2(B), .out(AxB));
    Adder a1(.A(C), .B(AxB), .out(C_next));
    
    always @(negedge clk) begin
        if(start)
            C = C_next;
        else
            C = C;
        pass_A <= A;
        pass_B <= B;
    end
    
endmodule