//Design code for carry select adder
`timescale 1ns/1ps
module full_adder (
    input  bit_a,
    input  bit_b,
    input  carry_in,
    output sum_out,
    output carry_out
);
    assign sum_out   = bit_a ^ bit_b ^ carry_in;
    assign carry_out = (bit_a & bit_b) | (bit_a & carry_in) | (bit_b & carry_in);
endmodule
module ripple_carry_adder_8bit (
    input  [7:0] operand_a,
    input  [7:0] operand_b,
    input        carry_in,
    output [7:0] sum_out,
    output       carry_out
);
    wire [8:0] carry_chain;
    
    assign carry_chain[0] = carry_in;
    
    generate
        for (genvar i = 0; i < 8; i = i + 1) begin : rca_loop
            full_adder adder_cell (
                .bit_a(operand_a[i]),
                .bit_b(operand_b[i]),
                .carry_in(carry_chain[i]),
                .sum_out(sum_out[i]),
                .carry_out(carry_chain[i+1])
            );
        end
    endgenerate
    
    assign carry_out = carry_chain[8];
endmodule
module carry_select_adder (
    input  [31:0] operand_a,
    input  [31:0] operand_b,
    input         carry_in,
    output [31:0] sum_out,
    output        carry_out
);
    wire [4:0] carry_select;  
    wire [7:0] sum_with_0 [3:0];  
    wire [7:0] sum_with_1 [3:0];  
    wire [3:0] carry_with_0;      
    wire [3:0] carry_with_1;      
    
    assign carry_select[0] = carry_in;
    
    ripple_carry_adder_8bit rca_first_block ( .operand_a(operand_a[7:0]),.operand_b(operand_b[7:0]),.carry_in(carry_select[0]),.sum_out(sum_out[7:0]),.carry_out(carry_select[1]));
    generate
        for (genvar block = 1; block < 4; block = block + 1) begin : csa_blocks
            ripple_carry_adder_8bit rca_carry0 (
                .operand_a(operand_a[8*block +: 8]),
                .operand_b(operand_b[8*block +: 8]),
                .carry_in(1'b0),
                .sum_out(sum_with_0[block]),
                .carry_out(carry_with_0[block])
            );
            ripple_carry_adder_8bit rca_carry1 (
                .operand_a(operand_a[8*block +: 8]),
                .operand_b(operand_b[8*block +: 8]),
                .carry_in(1'b1),
                .sum_out(sum_with_1[block]),
                .carry_out(carry_with_1[block])
            );
            assign sum_out[8*block +: 8] = carry_select[block] ? sum_with_1[block] : sum_with_0[block];
            assign carry_select[block+1] = carry_select[block] ? carry_with_1[block] : carry_with_0[block];
        end
    endgenerate
    assign carry_out = carry_select[4];
endmodule
//Test bench code for carry look ahead adder
`timescale 1ns/1ps
module carry_select_adder_tb;
    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg carry_in;
    wire [31:0] result_sum;
    wire carry_out;
    
    carryselect_adder adder_inst (
        .a(operand_a),
        .b(operand_b),
        .cin(carry_in),
        .sum(result_sum),
        .cout(carry_out)
    );
    
    initial begin
        $dumpfile("adder_simulation.vcd");
        $dumpvars(0, carry_select_adder_tb);
    end
    
    initial begin
        operand_a = 0;
        operand_b = 0;
        carry_in = 0;
        #10;
        
        operand_a = 1;
        operand_b = 1;
        carry_in = 0;
        #10;
        
        operand_a = 32'hFFFFFFFF;
        operand_b = 1;
        carry_in = 0;
        #10;
        
        operand_a = 32'hFFFFFFFF;
        operand_b = 32'hFFFFFFFF;
        carry_in = 0;
        #10;
        
        operand_a = 32'hFFFFFFFF;
        operand_b = 32'hFFFFFFFF;
        carry_in = 1;
        #10;
        
        operand_a = 32'h01BC0100;
        operand_b = 32'h0F100A01;
        carry_in = 0;
        #10;
        
        $display("All test cases completed");
        $finish;
    end
endmodule
