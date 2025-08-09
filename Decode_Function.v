//Design code for Decoder using functions
module Decoder_Func(I,Y);
  input[2:0] I;
  output reg[7:0] Y;
  function reg[7:0] D;
    input [2:0] In;
    integer i;
    begin
      D=8'b0;
    for (i=0; i<8; i = i+1) begin
      if (i == In) begin
        D[i] = 1'b1;
      end
    end
   end
  endfunction
      always@(*) begin
        Y = D(I);
      end
endmodule
//Testbench code for decoder using functions
module Decoder_Func_TB;
  reg [2:0] I;
  wire [7:0] Y;
  integer i;
  Decoder_Func DUT (.I(I),.Y(Y));
  initial begin 
    $dumpfile("Decoder_func.vcd");
    $dumpvars;
  end
  initial begin
    for(i=0;i<8;i= i +1) begin
      I = i[2:0]; #10;
    end
    $finish;
  end
endmodule
