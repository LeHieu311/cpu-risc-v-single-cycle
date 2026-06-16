`timescale 1ns/1ps

module fetch_tb;

reg clk;
reg rst;

wire [31:0] pc;
wire [31:0] pc_next;
wire [31:0] instr;

assign pc_next = pc + 4;

pc pc0(
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(pc)
);

instruction_memory imem(
    .addr(pc),
    .instr(instr)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #10;
    rst = 0;

    #60;

    $stop;
end

initial begin
    $monitor(
        "time=%0t PC=%d instr=%h",
        $time,
        pc,
        instr
    );
end

endmodule
