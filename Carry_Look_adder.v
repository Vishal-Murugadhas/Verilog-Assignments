//Design code for carry look ahead adder with 8 bit 
module Carry_adder#(parameter Bit=8)(A,B,Cin,C,G,P);
  input [Bit-1:0] A,B;
  input Cin;
  output [Bit:0] C;
  output [Bit-1:0] G,P;
  assign C[0]=Cin;
  genvar i;
  generate
    for (i=0;i<Bit;i=i+1) begin
      assign P[i]=(A[i] ^ B[i]);
      assign G[i]=(A[i] & B[i]);
      assign C[i+1]=G[i] | (P[i] & C[i]);
    end
  endgenerate
endmodule
//	Test bench for carry look ahead adder
`timescale 1ns\1ps
module CLA_TB #(Bit=8);
  reg [Bit-1:0]A,B;
  reg Cin;
  wire [Bit:0] C;
  wire [Bit-1:0] G, P;
  Carry_adder DUT(.A(A),.B(B),.Cin(Cin),.C(C),.G(G),.P(P));
  initial begin
    $dumpfile ("Carry_Adder.vcd");
    $dumpvars;
  end
  initial begin
     a = 8'b00000000; b = 8'b00000000; cin = 0; #10; 
    
    a = 8'b00000001; b = 8'b00000001; cin = 0; #10; 
    
    a = 8'b00000000; b = 8'b00000001; cin = 1; #10;  
   
    a = 8'b00000001; b = 8'b00000001; cin = 1; #10; 
    
    a = 8'b01001101; b = 8'b00101011; cin = 0; #10; 
    
    a = 8'b11111111; b = 8'b11111111; cin = 1; #10; 
    
    $finish;
  end
endmodule
