//XOR gate implementation using NAND gate
module XOR(A,B,O);
  input A,B;
  output O;
  wire W1,W2,W3;
  nand (W1,A,B);
  nand (W2,A,W1);
  nand (W3,B,W1);
  nand (O,W3,W2);
endmodule
//Test Bench code for XOR using NAND gate
`timescale 1ns/1ps
module XOR_TB;
  reg A,B;
  wire O;
  XOR DUT(.A(A),.B(B),.O(O));
  initial begin
    $dumpfile ("XOR_Implementation.vcd");
    $dumpvars;
  end
  initial begin
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule
