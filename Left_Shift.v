//Design code for left shifter ⬅️⬅️
module Left_Shifter(clk,I,Shift,X);
  input clk;
  input [7:0] I;
  input [2:0] Shift;
  output reg [7:0] X;
  always @(posedge clk) begin
    case (Shift)
      3'b000: begin
        X=I;
      end
      3'b001: begin
        X=I << 1;
      end
      3'b010: begin
        X=I << 2;
      end
      3'b011: begin
        X=I << 3;
      end
      3'b100: begin
        X=I << 4;
      end
      3'b101: begin
        X=I << 5;
      end
      3'b110: begin
        X=I << 6;
      end
      3'b111: begin
        X=I << 7;
      end
    endcase
  end
endmodule  

//Test bench code for 8 bit left shift register
`timescale 1ns/1ps
module L_Shift_TB;
  reg clk;
  reg [7:0] I;
  reg [2:0] Shift;
  wire [7:0] X;
  Left_Shifter DUT(.clk(clk),.I(I),.Shift(Shift),.X(X));
  initial begin
    clk=0;
    forever clk=~clk;#5;
  end
  initial begin
    $dumpfile("Left_Shifter.vcd");
    $dumpvars(0,L_Shift_TB);
  end
  initial begin
    I=8'b01001101;
    Shift=3'b010;#20;
    I=8'b11111010;
    Shift=3'b111;#20;
    I=8'b10110110;
    Shift=3'b001;#20;
    $finish;
  end
endmodule
