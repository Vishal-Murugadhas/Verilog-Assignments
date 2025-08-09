//Design code for gates implementation of MUX
module Mux_gates(A,B,Y,Z,W,V);
  input wire A,B;
  output wire Y,Z,W,V;
  assign Y =  (~A & 0) + (A & B ) ; 
  assign Z = ( B & ~A ) + ( 1'b1 & A); 
  assign W = (1'b1 & ~A) + (~B & A); 
  assign V = ( ~A & B) + ( A & ~B); 
endmodule
//Test bench code for implementation of gates using MUX
`timescale 1ns/1ps
module Mux_gate_TB;
  reg A,B;
  wire Y,Z,W,V;
  Mux_gates DUT (.A(A),.B(B),.Y(Y),.Z(Z),.W(W),.V(V));
  initial begin
    $dumpfile("MUX_GATES.vcd");
    $dumpvars;
  end
  initial begin
      A = 1'b0; B = 1'b0; #10;
      A = 1'b0; B = 1'b1; #10;
      A = 1'b1; B = 1'b0; #10;
      A = 1'b1; B = 1'b1; #10;
    $finish;
  end
endmodule
