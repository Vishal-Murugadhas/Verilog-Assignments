//3X4 Decoder using tasks 
module Decoder_Task(I,O);
  input [2:0] I;
  output reg [7:0] O;
  task Decoder;
    input [2:0] INP;
    output reg [7:0] OUT;
    begin
      OUT=8'b00000000;
      if (INP == 3'b000) begin
        OUT[0]=1;
      end else if (INP == 3'b001) begin
        OUT[1]=1;
      end else if (INP == 3'b010) begin
        OUT[2]=1;
      end else if (INP == 3'b011) begin
        OUT[3]=1;
      end else if (INP == 3'b100) begin
        OUT[4]=1;
      end else if (INP == 3'b101) begin
        OUT[5]=1;
      end else if (INP == 3'b110) begin
        OUT[6]=1;
      end else begin
        OUT[7]=1;
      end
    end
  endtask
  always @(*) begin
    Decoder(I,O);
  end
endmodule                            
//Test bench code for 3x8 Decoder using Tasks 
`timescale 1ns/1ps
module Decoder_TB;
  wire [7:0] O;
  reg [2:0] I;
  integer k;
  Decoder_Task(.I(I),.O(O));
  initial begin 
    $dumpfile("Decoder_Tasks.vcd");
    $dumpvars;
  end
  initial begin;
    for (k=0;k<8;k+=1) begin
      I=k; #10;
    end
    $finish;
  end
endmodule
