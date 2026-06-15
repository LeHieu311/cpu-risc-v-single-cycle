`timescale 1ns/1ps

module control_unit_tb;

reg [6:0] opcode;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemToReg;
wire Branch;
wire Jump;
wire [1:0] ALUOp;

control_unit uut (

    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp)

);

initial begin

    $monitor(
    "time=%0t opcode=%b RW=%b AS=%b MR=%b MW=%b MTR=%b BR=%b JP=%b ALUOp=%b",
    $time,
    opcode,
    RegWrite,
    ALUSrc,
    MemRead,
    MemWrite,
    MemToReg,
    Branch,
    Jump,
    ALUOp
    );

    // R-type
    opcode = 7'b0110011;
    #10;

    // addi
    opcode = 7'b0010011;
    #10;

    // lw
    opcode = 7'b0000011;
    #10;

    // sw
    opcode = 7'b0100011;
    #10;

    // beq
    opcode = 7'b1100011;
    #10;

    // jal
    opcode = 7'b1101111;
    #10;

    $stop;

end

endmodule
