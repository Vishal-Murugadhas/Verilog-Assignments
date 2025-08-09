//Design code for Booth multiplier
module Booth_multiplier(A,B,P);
  input signed[7:0] A,B;
  output reg signed [15:0] P;
  integer i;
  reg signed [15:0] a;
  reg signed[7:0] q;
  reg Q0;
  always @(*) begin
    a = 0;
    q = B;
    Q0 = 0;
    for(i=0;i<8;i=i+1) begin
      if(q[0]==0 && Q0==1)
        a = a - A;
      else if(q[0]== 1 && Q0==0)
        a = a + A;
      {a,q,Q0}={a,q,Q0} >>> 1;
    end
    P = {a,q};
  end
endmodule
//Test bench code for booth multiplier
`timescale 1ns/1ps
module Booth_TB;
    reg signed [7:0] A, B;
    wire signed [15:0] P;
    Booth_multiplier DUT (.A(A), .B(B), .P(P));
    initial begin
      $dumpfile("Booth.vcd");
      $dumpvars;
    end
    initial begin
        A = 0; B = 1; #10;
        A = 2; B = 3; #10;
        A = 5; B = -2; #10;
        $finish;
    end
endmodule
