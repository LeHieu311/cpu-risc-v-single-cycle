module cpu_top(

    input clk,
    input rst

);


// PC
wire [31:0] pc;
wire [31:0] pc_next;

assign pc_next = pc + 4;


// Instruction

wire [31:0] instr;

// Instruction Fields

wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;

assign opcode = instr[6:0];
assign rd     = instr[11:7];
assign funct3 = instr[14:12];
assign rs1    = instr[19:15];
assign rs2    = instr[24:20];
assign funct7 = instr[31:25];

// Control Signals

wire RegWrite;
wire MemRead;
wire MemWrite;
wire ALUSrc;
wire MemToReg;
wire Jump;
wire Branch;

wire [1:0] ALUOp;

// Register File
wire [31:0] rs1_data;
wire [31:0] rs2_data;

// Immediate Generator
wire [31:0] imm;

// ALU Control
wire [3:0] alu_ctrl;

// ALU
wire [31:0] alu_in2;
wire [31:0] alu_result;
wire zero;

// Data Memory
wire [31:0] read_data;

// Write Back
wire [31:0] wb_data;

// PC

pc pc0(

    .clk(clk),
    .rst(rst),

    .pc_next(pc_next),
    .pc(pc)

);

// Instruction Memory
instruction_memory imem(

    .addr(pc),
    .instr(instr)

);

// Control Unit
control_unit cu(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .ALUSrc(ALUSrc),
    .MemToReg(MemToReg),
    .Jump(Jump),
    .Branch(Branch),
    .ALUOp(ALUOp)

);

// Register File
reg_file rf(

    .clk(clk),
    .rst(rst),

    .reg_write(RegWrite),

    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),

    .write_data(wb_data),

    .read_data1(rs1_data),
    .read_data2(rs2_data)

);

// Immediate Generator
imm_gen ig(

    .instr(instr),
    .imm(imm)

);

// ALU Control
alu_control alu_ctrl0(

    .ALUOp(ALUOp),

    .funct3(funct3),
    .funct7(funct7),

    .alu_ctrl(alu_ctrl)

);

// ALUSrc MUX
assign alu_in2 =
        (ALUSrc) ? imm :
                   rs2_data;

// ALU
alu alu0(

    .a(rs1_data),
    .b(alu_in2),

    .alu_ctrl(alu_ctrl),

    .result(alu_result),
    .zero(zero)

);

// Data Memory
data_memory dmem(

    .clk(clk),

    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .addr(alu_result),

    .write_data(rs2_data),

    .read_data(read_data)

);

// Write Back MUX
assign wb_data =
        (MemToReg) ? read_data :
                     alu_result;

endmodule
