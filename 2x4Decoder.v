//Design code for 2x4 decoder 
module Decoder(I0,I1,X0,X1,X2,X3);
  input I0,I1;
  output X0,X1,X2,X3;
  and(X0,~I0,~I1);
  and(X1,~I0,I1);
  and(X2,I0,~I1);
  and(X3,I0,I1);
endmodule
// testbench code
`timescale 1ns\1ps
module Decoder_tb;
  reg I0,I1;
  wire X0,X1,X2,X3; 
  Decoder DUT (.I0(I0),.I1(I1),.X0(X0),.X1(X1),.X2(X2),.X3(X3));
  initial begin
    $dumpfile("Decoder.vcd");
    $dumpvars;
  end
  initial begin
    I1 = 0; I0 = 0; #10;
    I1 = 0; I0 = 1; #10;
    I1 = 1; I0 = 0; #10;
    I1 = 1; I0 = 1; #10;
    $finish;
  end
endmodule
