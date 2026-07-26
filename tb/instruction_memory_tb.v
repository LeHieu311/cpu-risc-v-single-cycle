`timescale 1ns/1ps

module instruction_memory_tb;

reg [31:0] addr;
wire [31:0] instr;

instruction_memory uut(
    .addr(addr),
    .instr(instr)
);

initial begin

    $monitor(
        "time=%0t addr=%d instr=%h",
        $time,
        addr,
        instr
    );

    addr = 0;
    #10;

    addr = 4;
    #10;

    addr = 8;
    #10;

    addr = 12;
    #10;

    addr = 16;
    #10;

    $stop;

end

endmodule
