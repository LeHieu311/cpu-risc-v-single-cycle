`timescale 1ns/1ps

module reg_file_tb;

reg clk;
reg rst;
reg reg_write;

reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;

reg [31:0] write_data;

wire [31:0] read_data1;
wire [31:0] read_data2;

reg_file uut (
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Tao clock chu ki 10ns
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("time=%0t | rst=%b | reg_write=%b | rs1=%d | rs2=%d | rd=%d | write_data=%d | read_data1=%d | read_data2=%d",
             $time, rst, reg_write, rs1, rs2, rd, write_data, read_data1, read_data2);

    // Ghi
    rst = 1;
    reg_write = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;
    write_data = 0;

    #10;

    // Tat reset
    rst = 0;

    #10;

    // Ghi 100 vao x1
    rd = 5'd1;
    write_data = 32'd100;
    reg_write = 1;
    #10;

    // Ghi 200 vao x2
    rd = 5'd2;
    write_data = 32'd200;
    reg_write = 1;
    #10;

    // Doc x1 vao x2
    reg_write = 0;
    rs1 = 5'd1;
    rs2 = 5'd2;
    #10;

    // Thu ghi 999 vào x0
    rd = 5'd0;
    write_data = 32'd999;
    reg_write = 1;
    #10;

    // Doc x0 và x1
    reg_write = 0;
    rs1 = 5'd0;
    rs2 = 5'd1;
    #10;

    // Ghi 555 vào x5
    rd = 5'd5;
    write_data = 32'd555;
    reg_write = 1;
    #10;

    // Doc x5 và x2
    reg_write = 0;
    rs1 = 5'd5;
    rs2 = 5'd2;
    #10;

    $stop;
end

endmodule
