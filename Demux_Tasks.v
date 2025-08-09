//Design code for demux using tasks
module Demux_task(D,S,Y);
  input D;
  input [3:0] S;
  output reg [15:0] Y;
  task Demux;
    input Inp;
    input[3:0]Sel;
    output reg [15:0]Do;
    integer i;
    begin
     Do=16'b0;
      for(i=0;i<16;i=i+1) begin
        if(i == Sel) begin
          Do[i]= Inp;
        end
      end
    end
  endtask
  always @(*) begin
    Demux(D,S,Y);
  end
endmodule
//Test bench code for Demux using Functions
`timescale 1ns/1ps
module Demux_task_tb;
  reg D;
  reg [3:0] S;
  wire[15:0] Y;
  integer i;
  
  Demux_task DUT (.D(D),.S(S),.Y(Y));
  
  initial begin
    $dumpfile("Demux_task.vcd");
    $dumpvars;
  end
  initial begin
    D = 1;
    for(i=0;i<16;i= i+1) begin
      S = i;#10;
    end
      $finish;
    end
endmodule
