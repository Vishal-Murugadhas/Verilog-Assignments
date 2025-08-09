//Priority encoder design code
`timescale 1ns/1ps
module priority_encoder (
    input  input_0,    
    input  input_1,
    input  input_2,
    input  input_3,    
    output data_bit_0, 
    output data_bit_1, 
    output valid_flag  
);
    wire not_input_2;
    wire and_intermediate;
    
    or(data_bit_1, input_2, input_3);                    
    or(valid_flag, input_0, input_1, input_2, input_3);   
    not(not_input_2, input_2);                           
    and(and_intermediate, not_input_2, input_1);          
    or(data_bit_0, and_intermediate, input_3);            
endmodule
//Test bench code for priority encoder
module priority_encoder_tb;
    reg [3:0] I;  
    wire [1:0] O; 
    wire valid;   
    
    priority_encoder dut (
        .input_0(I[0]),
        .input_1(I[1]),
        .input_2(I[2]),
        .input_3(I[3]),
        .data_bit_0(O[0]),
        .data_bit_1(O[1]),
        .valid_flag(valid)
    );
    
    initial begin
        $dumpfile("priority_encoder_waveforms.vcd");
        $dumpvars;
    end
    
    initial begin
        I = 4'b0000; #10;  // No inputs active
        I = 4'b0001; #10;  // Only I[0] active
        I = 4'b0010; #10;  // Only I[1] active
        I = 4'b0100; #10;  // Only I[2] active
        I = 4'b1000; #10;  // Only I[3] active
        I = 4'b0011; #10;  // I[0] and I[1] active
        I = 4'b0110; #10;  // I[1] and I[2] active
        I = 4'b1100; #10;  // I[2] and I[3] active
        I = 4'b1111; #10;  // All inputs active
        $finish;
    end
endmodule
