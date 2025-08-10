// Design code for 2 bit Moore FSM
// initial state -> 00, Output ->0
// if input is 0 goes back to 00
// if input is 1 goes -> 01 output -> 1 
// if input to 01 is 0 it remains at 01
// if input is 1 it goes to -> 11 output -> 1
// from 11 input 1 or 0 will go to 00
module Moore_FSM(clk,I,O,Reset);
  input I,Reset,clk;
  output reg O;
  reg [1:0] S1,S2; 
  always @(posedge clk or posedge Reset) begin
      if (Reset == 1) begin 
        S1<=2'b00;
      end
      else begin
        S1<=S2;
      end
  end
  always @(*) begin
    S2=S1;
    O=0;
    case (S1)
      2'b00: begin 
        S2= (I==0)? 2'b00:2'b01;
        O=0;
      end
      2'b01 begin
        S2= (I==0) ? 2'b01:2'b11;
        O=1;
      end
      2'b11 begin
        S2= 2'b00;
        O=1;
      end
    endcase
  end
endmodule
//Test bench code for moore FSM design
`timescale 1ns/1ps

module tb_Moore_FSM;

  reg clk,Reset,I;
  wire O;

  Moore_FSM dut (.clk(clk),.I(I),.O(O),.Reset(Reset));

  always begin
    forever clk = ~clk;#5;
  end

  initial begin
    $dumpfile("moore_fsm_tb.vcd");
    $dumpvars;
    clk = 0;
    Reset = 1;
    I = 0;
    #12 Reset = 0;
    I = 0; #10;  
    I = 1; #10;
    I = 0; #10;
    I = 1; #10;
    I = 0; #10;
    I = 1; #10;
    I = 1; #10;
    I = 1; #10;
    Reset = 1; #10;
    Reset = 0; #10;
    $finish;
  end

  initial begin
    $monitor("T=%0t | clk=%b Reset=%b I=%b | O=%b | State(cur)=%b,State(next)=%b", $time, clk, Reset, I, O, dut.S1, dut.S2);
  end
endmodule
