//Design code for two unsigned 8 bit multiplication
module Multiplier(N1,N2,X);
  input [7:0] N1,N2;
  output [15:0] X;
  assign X=N1*N2;
endmodule
//Test bench code for unsigned 8 bit multiplication
`timescale 1ns/1ps
module Multi_TB;
  wire [15:0] X;
  reg [7:0] N1,N2;
  Multiplier DUT (.N1(N1),.N2(N2),.X(X));
  initial begin 
    $dumpfile("Multiplier.vcd");
    $dumpvars;
  end
  initial begin
    for (integer i=0;i<=255;i=i+1) begin
      for (integer k=255;k>=0;k=k-1) begin
        N1=i;N2=k;
      end
    end
    $finish
  end
endmodule
