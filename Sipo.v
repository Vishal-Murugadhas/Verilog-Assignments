//design code for 3 bit Serial input parallel out register
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
module Serial_Parallel_reg(i,q,clk,reset);
  input i,clk,reset;
  output[2:0] q;
  wire W1,W2;
  assign W1=q[0];
  assign W2=q[1];
  D_FF Flip1(.D(i),.Q(q[0]),.CLK(clk),.R(reset));
  D_FF Flip2(.D(W1),.Q(q[1]),.CLK(clk),.R(reset));
  D_FF Flip3(.D(W2),.Q(q[2]),.CLK(clk),.R(reset));
endmodule
//Test bench code for 3 bit Serial input parallel out register
`timescale 1ns/1ps
module Serial_Parallel_reg_tb;
    reg I, CLK, RST;
    wire [2:0] Q;
    Serial_Parallel_reg DUT(.i(I), .q(Q), .clk(CLK), .reset(RST));
    initial begin
        $dumpfile("sipo.vcd");
        $dumpvars(0, Serial_Parallel_reg_tb);
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    initial begin
        RST = 1;
        I = 0;
        #10 RST = 0;
        I = 1; #10;
        I = 0; #10;
        I = 1; #10;
        I = 1; #10;
        $finish;
    end
endmodule
