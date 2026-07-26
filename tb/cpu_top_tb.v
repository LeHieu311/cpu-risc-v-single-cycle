
`timescale 1ns/1ps

module cpu_top_tb;

reg clk;
reg rst;

cpu_top uut(

    .clk(clk),
    .rst(rst)

);

always #5 clk = ~clk;

initial begin

    $monitor(
        "time=%0t pc=%h instr=%h alu=%d wb=%d",
        $time,
        uut.pc,
        uut.instr,
        uut.alu_result,
        uut.wb_data
    );

    clk = 0;
    rst = 1;

    #10;
    rst = 0;

    #200;

    $stop;

end

endmodule