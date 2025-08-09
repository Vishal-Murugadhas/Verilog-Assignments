// Design code for 2x1 MUX
module MUXTER(I0,I1,S,O);
  input I0,I1,S;
  output wire O;
  assign O=(S==0)?I0:I1;
endmodule
//Test bench code for 2x1 Mux
`timescale 1ns/1ps
module MUX_TB;
  reg I0,I1,S;
  wire O;
  MUXTER DUT (.I0(I0),.I1(I1),.S(S),.O(O));
  initial begin 
    $dumpfile("MUX.vcd");
    $dumpvars;
  end
  initial begin
    I0=0;I1=0;S=0;#10;
    I0=0;I1=1;S=0;#10;
    I0=1;I1=0;S=0;#10;
    I0=1;I1=1;S=0;#10;
    I0=0;I1=0;S=1;#10;
    I0=0;I1=1;S=1;#10;
    I0=1;I1=0;S=1;#10;
    I0=1;I1=1;S=1;#10;
  end
endmodule
