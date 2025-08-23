module if_id(
    input clk,
    input reset,
    input [15:0] instr_in,
    input [15:0] pc_in,
    output reg [15:0] instr_out,
    output reg [15:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        instr_out <= 16'b0;
        pc_out <= 16'b0;
    end else begin
        instr_out <= instr_in;
        pc_out <= pc_in;
    end
end

endmodule
