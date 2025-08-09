//16X1 MUXTER using functions
module MUX(I,S,X);
  input [15:0] I;
  input [3:0] S;
  output reg X;
  function O;
    input [15:0] In;
    input [3:0] Sel;
    O=In[Sel];
  endfunction
  always @(*) begin
   X = O(I,S);
  end
endmodule
//Test bench code for 16X1 MUXTER
`timescale 1ns/1ps
module MUX_TB;
  wire X;
  reg [15:0] I;
  reg [3:0] S;  
  MUX DUT (.I(I), .S(S), .X(X));
  initial begin 
    $dumpfile("MUX_TB.vcd");
    $dumpvars(0, MUX_TB);
  end
  initial begin
    for (integer i = 0; i < 16; i = i + 1) begin
      I = 16'b0;    
      I[i] = 1'b1;  
      S = i[3:0];    
      #10;          
    end
    $finish;
  end
endmodule
