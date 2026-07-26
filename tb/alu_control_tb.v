`timescale 1ns/1ps

module alu_control_tb;

reg [1:0] ALUOp;
reg [2:0] funct3;
reg [6:0] funct7;

wire [3:0] alu_ctrl;

alu_control uut(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .alu_ctrl(alu_ctrl)
);

initial begin

    $monitor(
        "time=%0t ALUOp=%b funct7=%b funct3=%b alu_ctrl=%b",
        $time,
        ALUOp,
        funct7,
        funct3,
        alu_ctrl
    );

    // lw/sw/addi
    ALUOp = 2'b00;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // beq
    ALUOp = 2'b01;
    #10;

    // add
    ALUOp = 2'b10;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // sub
    ALUOp = 2'b10;
    funct3 = 3'b000;
    funct7 = 7'b0100000;
    #10;

    // and
    ALUOp = 2'b10;
    funct3 = 3'b111;
    funct7 = 7'b0000000;
    #10;

    // or
    ALUOp = 2'b10;
    funct3 = 3'b110;
    funct7 = 7'b0000000;
    #10;

    // xor
    ALUOp = 2'b10;
    funct3 = 3'b100;
    funct7 = 7'b0000000;
    #10;

    // slt
    ALUOp = 2'b10;
    funct3 = 3'b010;
    funct7 = 7'b0000000;
    #10;

    $stop;

end

endmodule
