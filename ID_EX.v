module id_ex(
    input clk,
    input reset,
    input [15:0] reg_data1_in,
    input [15:0] reg_data2_in,
    input [15:0] imm_in,
    input [3:0] rd_in,
    input [3:0] alu_op_in,
    input reg_write_in,
    input mem_read_in,
    input mem_write_in,
    output reg [15:0] reg_data1_out,
    output reg [15:0] reg_data2_out,
    output reg [15:0] imm_out,
    output reg [3:0] rd_out,
    output reg [3:0] alu_op_out,
    output reg reg_write_out,
    output reg mem_read_out,
    output reg mem_write_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        reg_data1_out <= 16'b0;
        reg_data2_out <= 16'b0;
        imm_out <= 16'b0;
        rd_out <= 4'b0;
        alu_op_out <= 4'b0;
        reg_write_out <= 0;
        mem_read_out <= 0;
        mem_write_out <= 0;
    end else begin
        reg_data1_out <= reg_data1_in;
        reg_data2_out <= reg_data2_in;
        imm_out <= imm_in;
        rd_out <= rd_in;
        alu_op_out <= alu_op_in;
        reg_write_out <= reg_write_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
    end
end

endmodule
