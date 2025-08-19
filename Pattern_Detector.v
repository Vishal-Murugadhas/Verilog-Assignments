//Design code for pattern detector detects-> 110 pattern from a 32-bit stream
module Pattern_Detector(clk,reset,I,X);
  input clk,reset;
  input I;
  output reg [3:0] X;
  reg S1,S2;
  reg V,k;
  always @(posedge clk or posedge reset) begin 
    if (reset ==1) begin
      S1<=0;
      X<=4'b0000;
    end else begin
      S1<=S2;
    end
  end
  always @(*) begin
    S2=S1;
    V=0;k=0;
    case (S2) 
      0: begin
        if (V==1) begin
          X=1+X;
          V=0;k=0;
        end else begin
          V=0;
          k=0;
        end
      end
      1: begin
        if (k==1) begin
          V=1;
          k=1;
        end else begin
          k=1;
        end
      end
    endcase
  end
endmodule
//Test bench code for pattern detection
`timescale 1ns/1ps
module Pattern_Detector_TB;
  reg clk, reset, I;
  wire [3:0] X;
  Pattern_Detector dut (clk, reset, I, X);
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    $dumpfile("Pattern.vcd");
    $dumpvars(0,Pattern_Detector_TB);
  end
  initial begin
    reset = 1;
    I = 0;
    #10 reset = 0;
    I = 1; #10;
    I = 1; #10;
    I = 0; #10;
    I = 1; #10;
    I = 1; #10;
    I = 0; #10;
    I = 1; #10;
    I = 0; #10;
    I = 0; #10;
    I = 1; #10;
    $finish;
  end
endmodule
