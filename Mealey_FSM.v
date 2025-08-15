//Design code for mealey FSM
`timescale 1ns/1ps
module mealey(I,X,clk,R);
  input I,clk,R;
  output reg X;
  reg [1:0] S1;
  reg [1:0] S2;
  always @(posedge clk or posedge R) begin
    if (R==1) begin
      S1<=2'b00;
      X<=0;
    end else begin
      S1<=S2;
    end
  end
  always @(*) begin
    case (S1) 
      2'b00: begin
        S2=(I==0)? 2'b00:2'b01;
        X=0;
      end
      2'b01: begin 
        S2=(I==0)? 2'b11:2'b01;
        X=(I==0)? 1:0;
      end
      2'b11: begin
        S2=(I==0)? 2'b00:2'b11;
        X=(I==0)? 0:1;
      end
    endcase
  end
endmodule
//Testbench code for mealey FSM
`timescale 1ns/1ps
module mealey_TB;
  wire X;
  reg I,clk,R;
  mealey DUT(.I(I),.X(X),.clk(clk),.R(R));
  initial begin
    clk=0;
    forever clk=~clk;#5;
  end
  initial begin
    $dumpfile("mealey_fsm.vcd");
    $dumpvars;
  end
  initial begin
    R=1;#10;
    I=0;#10;
    R=0;#10;
    I=0; #10;  
    I=1; #10;
    I=0; #10;
    I=1; #10;
    I=0; #10;
    I=1; #10;
    I=1; #10;
    I=1; #10;
    $finish;
  end
endmodule
