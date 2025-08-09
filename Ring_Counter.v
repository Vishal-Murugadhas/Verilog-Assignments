//Design code for 4 bit ring counter
`timescale 1ns/1ps
module D_FF(D,Q,CLK,R);
  input D,CLK,R;
  output reg Q;
  always @(posedge CLK or posedge R) begin
    if (R==1) begin
      Q<=0;
    end else if (D==0) begin
      Q<=0;
    end else begin 
      Q<=1;
    end
  end
endmodule
module Ring_counter(q,clk,reset);
  input clk,reset;
  output [3:0] q;
  wire W1,W2,W3,W4;
  assign W1=q[0];
  assign W2=q[3];
  assign W3=q[2];
  assign W4=q[1];
  D_FF Flip1(.D(W1),.Q(q[3]),.CLK(clk),.R(reset));
  D_FF Flip2(.D(W2),.Q(q[2]),.CLK(clk),.R(reset));
  D_FF Flip3(.D(W3),.Q(q[1]),.CLK(clk),.R(reset));
  D_FF Flip4(.D(W4),.Q(q[0]),.CLK(clk),.R(reset));
endmodule  
//Test bench code for 4 bit ring counter 
`timescale 1ns/1ps
module Ring_Tb;
  wire [3:0] q;
  reg clk,reset;
  Ring_counter DUT (.q(q),.clk(clk),.reset(reset));
  initial begin
    clk=0;
    forever clk=~clk;#5;
  end
  initial begin
    $dumpfile("Ring.vcd");
    $dumpvars;
  end
  initial begin
    reset=1; #20;
    reset=0;#180;
    $finish;
  end
endmodule
