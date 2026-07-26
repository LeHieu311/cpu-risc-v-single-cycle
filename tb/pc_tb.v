`timescale 1ns/1ps

module pc_tb;

reg clk;
reg rst;

reg [31:0] pc_next;

wire [31:0] pc;

pc uut(
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(pc)
);

always #5 clk = ~clk;

initial begin
    $monitor(
        "time=%0t rst=%b pc=%d",
        $time,
        rst,
        pc
    );
end

initial begin

    clk = 0;
    rst = 1;
    pc_next = 0;

    #10;

    rst = 0;

    pc_next = 4;
    #10;

    pc_next = 8;
    #10;

    pc_next = 12;
    #10;

    pc_next = 16;
    #10;

    $stop;

end

endmodule
