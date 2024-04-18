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
                output wire [7:0] M1_out, 
                output wire [7:0] M2_out, 
                output wire [7:0] M3_out, 
                output wire [7:0] M4_out, 
                output wire [7:0] M5_out, 
                output wire [7:0] M6_out, 
                output wire [7:0] M7_out, 
                output wire [7:0] M8_out, 
                output wire [7:0] M9_out, 
                output reg done
    );
   reg[7:0] a0 = 0; 
   reg[7:0] a1 = 0;
   reg[7:0] a2 = 0;
   reg[7:0] b0 = 0; 
   reg[7:0] b1 = 0;
   reg[7:0] b2 = 0;
   
      //Array Controls
    reg start0 = 0; reg start1 = 0; reg start2 = 0;
    reg start3 = 0; reg start4 = 0; reg start5 = 0;
    reg start6 = 0; reg start7 = 0; reg start8 = 0;
   
   wire[7:0]
   //pass 
   p0, p1, p2, p3, p4, p5,p11, p12, p21,p22, p31,p32, p41, p42, p51, p52,p6162,p71,p72,p81,p82;
   
 
 
   
   //Mac 1st row
   MACUnit m00(.clk(clk),    .start(start0),  .A(a0),         .B(b0),    .pass_A(p1),    .pass_B(p2),    .C(M1_out));
   MACUnit m01(.clk(clk),    .start(start1), .A(a1),     .B(p2),    .pass_A(p11),    .pass_B(p12),    .C(M2_out));
   MACUnit m02(.clk(clk),    .start(start2), .A(a3),     .B(p12),    .pass_A(p21),        .pass_B(p22),    .C(M3_out));

   //Mac 2nd row
   MACUnit m10(.clk(clk),    .start(start3), .A(p1),         .B(b1),    .pass_A(p31),    .pass_B(p32),    .C(M4_out));
   MACUnit m11(.clk(clk),    .start(start4), .A(p11),     .B(p32),    .pass_A(p41),    .pass_B(p42),    .C(M5_out));
   MACUnit m12(.clk(clk),    .start(start5), .A(p21),     .B(p42),    .pass_A(p51),        .pass_B(p52),    .C(M6_out));
   
   //Mac 3rd row
   MACUnit m20(.clk(clk),    .start(start6), .A(p31),         .B(b2),    .pass_A(p61),    .pass_B(p62),    .C(M7_out));
   MACUnit m21(.clk(clk),    .start(start7), .A(p41),     .B(p62),    .pass_A(p71),    .pass_B(p72),    .C(M8_out));
   MACUnit m22(.clk(clk),    .start(start8), .A(p51),     .B(p72),    .pass_A(p81),        .pass_B(p82),    .C(M9_out));
   
   //State
   reg[4:0] state;
   reg[4:0] next_state;
   initial begin 
        state = 0; 
        next_state = 0;
    end
   
  
   //FSM
   always @(*) begin
   case(state)
   //Return matrix: 00<-(a00, b00) (inputs)
    1: begin
        a0 = a00;
        a1 = 0;
        a2 = 0;
        b0 = b00;
        b1 = 0;
        b2 = 0;
        
             start0 = 1; start1 = 0; start2 = 0;
                start3 = 0; start4 = 0; start5 = 0;
                start6 = 0; start7 = 0; start8 = 0;
        next_state = 1;
    end
    //Return matrix: 00<-(a01, b10) 10<-(a10) 01<-(b01)
    1: begin
        a0 = a01;
        a1 = a10;
        a2 = 0;
        b0 = b10;
        b1 = b01;
        b2 = 0;
           start0 = 1; start1 = 1; start2 = 0;
                start3 = 1; start4 = 0; start5 = 0;
                start6 = 0; start7 = 0; start8 = 0;
        
        next_state = 2;
    end
    //Return matrix: 00<-(a02, b20) 10<-(a11) 01<-(b11) 20<-(a20) 02<-(b02)
    2: begin
        a0 = a02;
        a1 = a11;
        a2 = a20;
        b0 = b20;
        b1 = b11;
        b2 = b02;
        
         start0 = 1; start1 = 1; start2 = 1;
                start3 = 1; start4 = 1; start5 = 0;
                start6 = 1; start7 = 0; start8 = 0;
        next_state = 3;
    end
    //Return matrix: 10<-(a12) 01<-(b21) 20<-(a21) 02<-(b12)
    3: begin
        a0 = 0;
        a1 = a12;
        a2 = a21;
        b0 = 0;
        b1 = b21;
        b2 = b12;
        
         start0 = 0; start1 = 1; start2 = 1;
                start3 = 1; start4 = 1; start5 = 1;
                start6 = 1; start7 = 1; start8 = 0;
        next_state = 4;
    end
    //Return matrix: 20<-(a22) 02<-(b22)
    4: begin
        a0 = 0;
        a1 = 0;
        a2 = a22;
        b0 = 0;
        b1 = 0;
        b2 = b22;
        
         start0 = 0; start1 = 0; start2 = 1;
                start3 = 0; start4 = 1; start5 = 1;
                start6 = 1; start7 = 1; start8 = 1;
        next_state = 5;
    end
    //Final state
    5: begin
        a0 = 0;
        a1 = 0;
        a2 = 0;
        b0 = 0;
        b1 = 0;
        b2 = 0;
                start0 = 0; start1 = 0; start2 = 0;
                start3 = 0; start4 = 0; start5 = 1;
                start6 = 0; start7 = 1; start8 = 1;
        state = 6;
    end
    6: begin
       
                start0 = 0; start1 = 0; start2 = 0;
                start3 = 0; start4 = 0; start5 = 0;
                start6 = 0; start7 = 0; start8 = 1;
        next_state = 7;
    end
    7: begin
        start8 = 0;
        next_state = 8;
    end
    8: begin //last state
        done = 1;
    end
    default:
            begin
            a0 = 0;
            a1 = 0;
            a2 = 0;
            b0 = 0;
            b1 = 0;
            b2 = 0;
            
                start0 = 0; start1 = 0; start2 = 0;
                start3 = 0; start4 = 0; start5 = 0;
                start6 = 0; start7 = 0; start8 = 0;
                
                next_state = 0;
            end
   endcase
   end
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            state <= 0;
        else
            state <= next_state;
    end
endmodule


