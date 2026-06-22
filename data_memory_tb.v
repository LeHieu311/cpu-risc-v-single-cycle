`timescale 1ns/1ps

module data_memory_tb;

reg clk;

reg MemRead;
reg MemWrite;

reg [31:0] addr;
reg [31:0] write_data;

wire [31:0] read_data;

data_memory uut(

    .clk(clk),

    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .addr(addr),
    .write_data(write_data),

    .read_data(read_data)

);

always #5 clk = ~clk;

initial begin

    clk = 0;

    MemRead = 0;
    MemWrite = 0;



    addr = 4;
    write_data = 100;

    MemWrite = 1;

    #10;

    MemWrite = 0;


    addr = 20;
    write_data = 555;

    MemWrite = 1;

    #10;

    MemWrite = 0;



    addr = 4;
    MemRead = 1;

    #10;

    addr = 20;

    #10;


    addr = 8;

    #10;

    $stop;

end

initial begin

    $monitor(
        "time=%0t addr=%d write=%d read=%d",
        $time,
        addr,
        write_data,
        read_data
    );

end

endmodule
