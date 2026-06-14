`timescale 1ns/1ps

module imm_gen_tb;

reg [31:0] instr;
wire [31:0] imm;

imm_gen uut(
    .instr(instr),
    .imm(imm)
);

// Theo dõi tín hi?u
initial begin
    $monitor(
        "Time=%0t | instr=%h | imm=%0d",
        $time,
        instr,
        $signed(imm)
    );
end

initial begin

    // I-type: addi x1,x0,5
    instr = 32'h00500093;
    #10;

    // I-type: addi x1,x0,-1
    instr = 32'hFFF00093;
    #10;

    // S-type: sw x2,8(x1)
    instr = 32'h0020A423;
    #10;

    // B-type
    instr = 32'h00208463;
    #10;

    // J-type
    instr = 32'h008000EF;
    #10;

    $stop;

end

endmodule
