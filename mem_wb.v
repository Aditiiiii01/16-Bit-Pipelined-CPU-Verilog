module mem_wb(
    input clk,
    input reset,
    input [15:0] mem_data_in,
    input [15:0] alu_result_in,
    input [3:0] rd_in,
    input reg_write_in,
    output reg [15:0] mem_data_out,
    output reg [15:0] alu_result_out,
    output reg [3:0] rd_out,
    output reg reg_write_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        mem_data_out <= 16'b0;
        alu_result_out <= 16'b0;
        rd_out <= 4'b0;
        reg_write_out <= 0;
    end else begin
        mem_data_out <= mem_data_in;
        alu_result_out <= alu_result_in;
        rd_out <= rd_in;
        reg_write_out <= reg_write_in;
    end
end

endmodule
