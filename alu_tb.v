`timescale 1ns/1ps

module alu_tb;

reg  [31:0] a;
reg  [31:0] b;
reg  [3:0]  alu_ctrl;
wire [31:0] result;
wire zero;

alu uut (
    .a(a),
    .b(b),
    .alu_ctrl(alu_ctrl),
    .result(result),
    .zero(zero)
);

initial begin
    $monitor("time=%0t | a=%d | b=%d | alu_ctrl=%b | result=%d | zero=%b",
             $time, a, b, alu_ctrl, result, zero);

    // ADD: 10 + 5 = 15
    a = 32'd10;
    b = 32'd5;
    alu_ctrl = 4'b0000;
    #10;

    // SUB: 10 - 5 = 5
    a = 32'd10;
    b = 32'd5;
    alu_ctrl = 4'b0001;
    #10;

    // AND
    a = 32'b1010;
    b = 32'b1100;
    alu_ctrl = 4'b0010;
    #10;

    // OR
    a = 32'b1010;
    b = 32'b1100;
    alu_ctrl = 4'b0011;
    #10;

    // XOR
    a = 32'b1010;
    b = 32'b1100;
    alu_ctrl = 4'b0100;
    #10;

    // SLT: 5 < 10 = 1
    a = 32'd5;
    b = 32'd10;
    alu_ctrl = 4'b0101;
    #10;

    // Test zero: 5 - 5 = 0
    a = 32'd5;
    b = 32'd5;
    alu_ctrl = 4'b0001;
    #10;

    $stop;
end

endmodule
