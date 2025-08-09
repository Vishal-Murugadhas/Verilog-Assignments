// Two bit comparator 
module Comparator(A,B,X,Y,Z);
  input [1:0]A,B;
  output X,Y,Z;
  assign X=((A[1] ~^ B[1]) & (A[0] ~^ B[0]));
  assign Y=((A[1] & ~B[1]) | ((A[1] ~^ B[1]) & (A[0] & ~B[0]) ));
  assign Z=((~A[1] & B[1]) | ((A[1] ~^ B[1]) & (~A[0] & B[0]) ));
endmodule
// Test bench code for two bit comparator
`timescale 1ns/1ps
module Comparator_tb;
  reg [1:0] A;
  reg [1:0] B;
  wire X;  // A == B
  wire Y;  // A > B
  wire Z;  // A < B
  
  Comparator DUT (.A(A),.B(B),.X(X),.Y(Y),.Z(Z));
  initial begin
    $dumpfile("comparator_2.vcd");
    $dumpvars;
  end
  
  initial begin
    A = 2'b00; B = 2'b00; #10;
    A = 2'b00; B = 2'b01; #10;
    A = 2'b00; B = 2'b10; #10;
    A = 2'b00; B = 2'b11; #10;
    A = 2'b01; B = 2'b00; #10;
    A = 2'b01; B = 2'b01; #10;
    A = 2'b01; B = 2'b10; #10;
    A = 2'b01; B = 2'b11; #10;
    A = 2'b10; B = 2'b00; #10;
    A = 2'b10; B = 2'b01; #10;
    A = 2'b10; B = 2'b10; #10;
    A = 2'b10; B = 2'b11; #10;
    A = 2'b11; B = 2'b00; #10;
    A = 2'b11; B = 2'b01; #10;
    A = 2'b11; B = 2'b10; #10;
    A = 2'b11; B = 2'b11; #10;
    $finish;
  end
  
endmodule
