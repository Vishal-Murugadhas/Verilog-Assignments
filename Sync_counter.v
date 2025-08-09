//Design code for 3 bit synchronous counter
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
module Sync_Counter(Q,clk,reset);
  input clk,reset;
  output wire [2:0] Q;
  wire w1,w2;
  and(w1,Q[1],Q[0]);
  JK_FF FLIPFLOP (.j(w1),.k(w1),.CLK(clk),.r(reset),.q(Q[2]));
  JK_FF FLIPFLOP1 (.j(Q[0]),.k(Q[0]),.CLK(clk),.r(reset),.q(Q[1]));
  JK_FF FLIPFLOP2 (.j(1'b1),.k(1'b1),.CLK(clk),.r(reset),.q(Q[0]));
endmodule
//Test bench code for synchronous counter
`timescale 1ns/1ps
module Sync_Counter_TB;
  wire [2:0] Q;
  reg reset;
  reg clk=0;
  Sync_Counter DUT(.Q(Q),.clk(clk),.reset(reset));
  initial begin
    $dumpfile("Synccounter.vcd");
    $dumpvars;
  end
  initial begin
    forever clk=~clk;#5;
  end
  initial begin
    reset=1;#100;
    reset=0;#180;
    $finish;
  end
endmodule
