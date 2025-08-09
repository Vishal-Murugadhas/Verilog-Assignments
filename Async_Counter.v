//Design code for 3 bit up/down asynchronous counter
`timescale 1ns/1ps
module JK_FF(j,k,CLK,r,q);
    input j,k;
    input CLK,r;
    output reg q;
    always @(posedge CLK or posedge r) begin
      if (r==1) begin
        q<= 0;
      end else if (j==0 && k==0) begin
        q<=q;
      end else if (j==0 && k==1) begin
        q<=0;
      end else if (j==1 && k==0) begin
        q<=1;
      end else begin
        q<=~q;
      end
    end
endmodule
module Async_Counter(S,Q,clk,reset);
  input S,clk,reset; //S=0 DOWN COUNT,S=1 UP COUNT
  output [2:0] Q;
  wire W1,W2;
  xor(W1,Q[2],S);
  xor(W2,Q[1],S);
  JK_FF Fliper1(.j(1'b1),.k(1'b1),.CLK(clk),.r(reset),.q(Q[2]));
  JK_FF Fliper2(.j(1'b1),.k(1'b1),.CLK(W1),.r(reset),.q(Q[1]));
  JK_FF Fliper3(.j(1'b1),.k(1'b1),.CLK(W2),.r(reset),.q(Q[0]));
endmodule 
//Test bench code for 3 bit async counter with select line 
`timescale 1ns/1ps
module Async_Counter_TB;
  reg S,reset;
  wire [2:0] Q;
  reg clk=0;
  Async_Counter DUT (.S(S),.Q(Q),.clk(clk),.reset(reset));
  initial begin
        $monitor("Time = %0t: S = %b, Q = %3b, reset = %b", $time, S, Q, reset);
  end
  initial begin
    forever clk=~clk; #5;
  end
  initial begin
    reset=1;
    S=0; #20;
    S=1; #20;
    reset=0;S=0;#180;
    reset=0;S=1;#180;
    $finish;
  end
endmodule
