module reg_file (
    input clk,
    input rst,

    input reg_write,

    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,

    input [31:0] write_data,

    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] regs [0:31];

integer i;

// Ghi d? li?u vào thanh ghi
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1) begin
            regs[i] <= 32'b0;
        end
    end else begin
        if (reg_write && rd != 5'd0) begin
            regs[rd] <= write_data;
        end
    end
end

// ??c d? li?u t? thanh ghi
assign read_data1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
assign read_data2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

endmodule
