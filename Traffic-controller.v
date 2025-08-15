//Design code for traffic light controller 🔴🟡🟢
`timescale 1ns/1ps
module Traffic_light(reset,clk,R,Y,G);
  input reset,clk;
  output reg R,Y,G;
  typedef enum{RED,YELLOW,GREEN} State;
  State S1,S2;
  reg [7:0] cycle;
  always @(posedge clk or posedge reset) begin
    if (reset==1) begin
      R<=1;
      Y<=0;
      G<=0;
      S1<=RED;
    end else begin
      S1<=S2;
    end
    if (cycle==0) begin
      case (S1)
        RED: cycle<=20;
        YELLOW: cycle<=2;
        GREEN: cycle<=15;
      endcase
    end else begin
      cycle<=cycle-1;
    end
  end
  always @(*) begin
    case (S2) 
      RED: begin
        R=1;
        Y=0;
        G=0;
        S2=(cycle==0)? GREEN:RED;
      end
      GREEN: begin
        R=0;Y=0;G=1;
        S2=(cycle==0)? YELLOW:GREEN;
      end
      YELLOW: begin
        R=0;Y=1;G=0;
        S2=(cycle==0)? RED:YELLOW;
      end
    endcase
  end 
endmodule
//Testbench code for traffic light controller\
`timescale 1ns/1ps
module traffic_TB;
  reg reset,clk;
  wire R,Y,G;
  Traffic_light DUT (.reset(reset),.clk(clk),.R(R),.Y(Y),.G(G));
  initial begin
    clk=0;
    forever clk=~clk;#5;
  end
  initial begin
    $dumpfile("Traffic_controller.vcd");
    $dumpvars;
  end
  initial begin
    reset=1;#20;
    reset=0#120;
    $finish;
  end
endmodule
