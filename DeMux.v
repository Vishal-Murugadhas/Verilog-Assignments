//Design code for Demux 
module Demux(I,S,X0,X1);
  input I,S;
  output wire X0,X1;
  assign X0= I & ~S;
  assign X1= I & S;
endmodule
// Test bench code for Demux
`timescale 1ns/1ps
module Demux_TB;
  wire X0,X1;
  reg I,S;
  Demux DUT (.I(I),.S(S),.X0(X0),.X1(X1));
  initial begin
    $dumpfile("Demux.vcd");
    $dumpvars;
  end
  initial begin
    I=0;S=0;#10;
    I=0;S=1;#10;
    I=1;S=0;#10;
    I=1;S=1;#10;
  end
endmodule
