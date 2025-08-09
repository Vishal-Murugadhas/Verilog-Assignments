//Decimal to BCD converter
module BCD_Converter(N,O,U);
  input [3:0] N;
  output wire [3:0] O,U;
  wire [4:0] W;
  assign W= N+ 4'b0110;
  assign O= (N>= 4'b1010) ? 4'b0001:4'b0000;
  assign U= (N>= 4'b1010) ? W[3:0]:N;
endmodule
//Test bench code For Decimal to BCD converter
`timescale 1ns/1ps
module BCD_Converter_TB;
  reg N;
  wire O,U;
  BCD_Converter DUT(.N(N),.O(O),.U(U));
  initial begin
    $dumpfile("BCD_Converter.vcd");
    $dumpvars;
  end
  initial begin
    N=4'b0001; #10;
    N=4'b0011; #10;
    N=4'b0010; #10;
    N=4'b0100; #10;
    N=4'b0101; #10;
    N=4'b1001; #10;
    N=4'b1011; #10;
    N=4'b1100; #10;
    N=4'b1101; #10;
    N=4'b1111; #10;
  end
endmodule
