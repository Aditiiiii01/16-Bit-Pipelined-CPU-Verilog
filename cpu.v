module cpu(
    input clk,
    input reset
);

    // -------------------------------
    // IF Stage
    // -------------------------------
    reg [15:0] pc;
    wire [15:0] instr_if;
    wire [15:0] pc_next;

    // Instruction memory (simple example)
    reg [15:0] instr_mem [0:255]; // 256x16 instruction memory
    assign instr_if = instr_mem[pc];

    assign pc_next = pc + 1;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc_next;
    end

    // -------------------------------
    // IF/ID Pipeline Register
    // -------------------------------
    wire [15:0] if_id_instr, if_id_pc;
    if_id ifid_reg(
        .clk(clk),
        .reset(reset),
        .instr_in(instr_if),
        .pc_in(pc),
        .instr_out(if_id_instr),
        .pc_out(if_id_pc)
    );

    // -------------------------------
    // ID Stage
    // -------------------------------
    wire [3:0] rs = if_id_instr[11:8];
    wire [3:0] rt = if_id_instr[7:4];
    wire [3:0] rd = if_id_instr[3:0];
    wire [15:0] reg_out1, reg_out2;

    // Register file
    registers regfile(
        .clk(clk),
        .we(mem_wb_reg_write),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(mem_wb_rd),
        .write_data(mem_wb_data),
        .read_data1(reg_out1),
        .read_data2(reg_out2)
    );

    // Control signals
    wire reg_write, mem_read, mem_write;
    wire [3:0] alu_op;
    control ctrl_unit(
        .opcode(if_id_instr[15:12]),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op)
    );

    // -------------------------------
    // ID/EX Pipeline Register
    // -------------------------------
    wire [15:0] id_ex_reg1, id_ex_reg2;
    wire [3:0] id_ex_rd;
    wire [3:0] id_ex_alu_op;
    wire id_ex_reg_write, id_ex_mem_read, id_ex_mem_write;

    id_ex idex_reg(
        .clk(clk),
        .reset(reset),
        .reg_data1_in(reg_out1),
        .reg_data2_in(reg_out2),
        .imm_in(16'b0),          // Not using immediate for simplicity
        .rd_in(rd),
        .alu_op_in(alu_op),
        .reg_write_in(reg_write),
        .mem_read_in(mem_read),
        .mem_write_in(mem_write),
        .reg_data1_out(id_ex_reg1),
        .reg_data2_out(id_ex_reg2),
        .imm_out(),
        .rd_out(id_ex_rd),
        .alu_op_out(id_ex_alu_op),
        .reg_write_out(id_ex_reg_write),
        .mem_read_out(id_ex_mem_read),
        .mem_write_out(id_ex_mem_write)
    );

    // -------------------------------
    // EX Stage
    // -------------------------------
    wire [15:0] alu_result;
    wire zero_flag;
    alu myALU(
        .a(id_ex_reg1),
        .b(id_ex_reg2),
        .alu_control(id_ex_alu_op),
        .result(alu_result),
        .zero(zero_flag)
    );

    // -------------------------------
    // EX/MEM Pipeline Register
    // -------------------------------
    wire [15:0] ex_mem_alu_result, ex_mem_reg2;
    wire [3:0] ex_mem_rd;
    wire ex_mem_reg_write, ex_mem_mem_read, ex_mem_mem_write;

    ex_mem exmem_reg(
        .clk(clk),
        .reset(reset),
        .alu_result_in(alu_result),
        .reg_data2_in(id_ex_reg2),
        .rd_in(id_ex_rd),
        .reg_write_in(id_ex_reg_write),
        .mem_read_in(id_ex_mem_read),
        .mem_write_in(id_ex_mem_write),
        .alu_result_out(ex_mem_alu_result),
        .reg_data2_out(ex_mem_reg2),
        .rd_out(ex_mem_rd),
        .reg_write_out(ex_mem_reg_write),
        .mem_read_out(ex_mem_mem_read),
        .mem_write_out(ex_mem_mem_write)
    );

    // -------------------------------
    // MEM Stage
    // -------------------------------
    reg [15:0] data_mem [0:255]; // simple data memory
    wire [15:0] mem_data_out;

    assign mem_data_out = (ex_mem_mem_read) ? data_mem[ex_mem_alu_result] : 16'b0;

    always @(posedge clk) begin
        if (ex_mem_mem_write)
            data_mem[ex_mem_alu_result] <= ex_mem_reg2;
    end

    // -------------------------------
    // MEM/WB Pipeline Register
    // -------------------------------
    wire [15:0] mem_wb_data;
    wire [3:0] mem_wb_rd;
    wire mem_wb_reg_write;

    mem_wb memwb_reg(
        .clk(clk),
        .reset(reset),
        .mem_data_in(mem_data_out),
        .alu_result_in(ex_mem_alu_result),
        .rd_in(ex_mem_rd),
        .reg_write_in(ex_mem_reg_write),
        .mem_data_out(),
        .alu_result_out(mem_wb_data),
        .rd_out(mem_wb_rd),
        .reg_write_out(mem_wb_reg_write)
    );

    // -------------------------------
    // Hazard Unit
    // -------------------------------
    wire stall, forwardA, forwardB;
    hazard_unit hazard(
        .id_ex_rd(id_ex_rd),
        .if_id_rs(rs),
        .if_id_rt(rt),
        .id_ex_mem_read(id_ex_mem_read),
        .stall(stall),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

endmodule
