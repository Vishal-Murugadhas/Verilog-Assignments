//Design code for lift controller 3 floors->G,1,2
module Lift_controller(clk,reset,G,F,S);
  input clk,reset;
  input G,S;//G->Ground floor goes up,S->Second floor goes down
  input [1:0] F;//F[0]->Down,F[1]->Up
  typedef enum {Ground,First,Second} Floor;
  Floor S1,S2;//S1->Initial floor S2->Next floor
  always @(posedge clk or posedge reset) begin
    if (reset==1) begin
      S1<=Ground;
    end else begin
      S1<=S2;
    end
  end
  always @(*) begin
    S2=S1;
    case (S2)
      Ground: begin
        if (S==1) begin
          if (F[1]==0) begin
            S2=Second;
          end else begin
            S2=First;
          end
        end else if (F[0] || F[1]) begin
          S2=First;
        end else begin
          S2=Ground;
        end
      end
      First: begin
        if (S==1) begin
          S2=Second;
        end else if (G==1) begin
          S2=Ground;
        end else begin
          S2=First;
        end
      end
      Second:begin
        if (G==1) begin
          if (F[0]==0) begin
            S2=Ground;
          end else begin
            S2=First;
          end
        end else if (F[0] || F[1]) begin
          S2=First;
        end else begin
          S2=Second;
        end
      end
    endcase
  end
endmodule
//Test bench code for lift controller
`timescale 1ns/1ps;
module Lift_TB;
  reg clk,reset;
  reg G,S;
  reg [1:0] F;
  Lift_controller DUT (.clk(clk),.reset(reset),.G(G),.F(F),.S(S));
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  initial begin
    $dumpfile("Lift_controller.vcd");
    $dumpvars(0,Lift_TB);
  end
  initial begin
    reset=1;
    G=1;
    F=2'b00;
    S=0;#10;
    reset=0;
    G=0;F=2'b01;S=0;#10;
    G=0;F=2'b00;S=1;#10;
    G=1;F=2'b10;S=0;#10;
    G=0;F=2'b00;S=1;#10;
    $finish;
  end
endmodule
