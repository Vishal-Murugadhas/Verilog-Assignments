//Design code for encoder 8x3
module Encoder(I0,I1,I2,I3,I4,I5,I6,I7,X0,X1,X2);
  input I0,I1,I2,I3,I4,I5,I6,I7;
  output X0,X1,X2;
  or(X0,I1,I3,I5,I7);
  or(X1,I2,I3,I6,I7);
  or(X2,I4,I5,I6,I7);
endmodule
//Test bench for encoder
`timescale 1ns/1ps
module Encoder_TB;
  reg I0,I1,I2,I3,I4,I5,I6,I7;
  wire X0,X1,X2;
  Encoder DUT (.I0(I0),.I1(I1),.I2(I2),.I3(I3),.I4(I4),.I5(I5),.I6(I6),.I7(I7),.X0(X0),.X1(X1),.X2(X2));
  initial begin 
    $dumpfile("Encoder.vcd");
    $dumpvars;
  end
  initial begin 
    I0=1;I1=0;I2=0;I3=0;I4=0;I5=0;I6=0;I7=0; #10;
    I0=0;I1=1;I2=0;I3=0;I4=0;I5=0;I6=0;I7=0; #10;
    I0=0;I1=0;I2=1;I3=0;I4=0;I5=0;I6=0;I7=0; #10;
    I0=0;I1=0;I2=0;I3=1;I4=0;I5=0;I6=0;I7=0; #10;
    I0=0;I1=0;I2=0;I3=0;I4=1;I5=0;I6=0;I7=0; #10;
    I0=0;I1=0;I2=0;I3=0;I4=0;I5=1;I6=0;I7=0; #10;
    I0=0;I1=0;I2=0;I3=0;I4=0;I5=0;I6=1;I7=0; #10;
    I0=0;I1=0;I2=0;I3=0;I4=0;I5=0;I6=0;I7=1; #10;
    $finish;
  end
endmodule
