//Full adder 
module Full_Adder(A,B,Cin,S,Cout);
      input A,B,Cin;
      output S,Cout;
      wire w1,w2,w3;
      xor (S,A,B,Cin);
      assign Cout=(A&B)|(A&Cin)|(B&Cin);
endmodule
//Test bench code
`timescale 1ns/1ps
module TB_Full_Adder;
     reg A,B,Cin;
     wire S,Cout;
     Full_Adder DUT(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));
     initial begin 
           $dumpfile(Full_Adder.vcd);
           $dumpvars;
     end
     initial begin
           A=0;B=0;Cin=0; #10;
           A=0;B=0;Cin=1; #10;
           A=0;B=1;Cin=0; #10;
           A=0;B=1;Cin=1; #10;
           A=1;B=0;Cin=0; #10;
           A=1;B=0;Cin=1; #10;
           A=1;B=1;Cin=0; #10;
           A=1;B=1;Cin=1; #10;
           $finish;
     end
endmodule
