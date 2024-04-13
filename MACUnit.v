
module MACUnit(
    input wire clk,
    input wire [7:0] A, B,
    output wire [7:0] pass_A, pass_B,
    output reg [7:0] C //Final output
    );
    
    initial begin C = 0; pass_A = 0; pass_B = 0; end
    
    reg [7:0] AxB;
    reg [7:0] C_next;
    Multiplier m1(.in1(A), .in2(B), .out(AxB));
    Adder a1(.A(C), .B(AxB), .out(C_next));
    
    always @(posedge clk) begin
        C = C_next;
        pass_A = A;
        pass_B = B;
    end
    
endmodule