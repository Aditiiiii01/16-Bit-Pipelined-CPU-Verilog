module registers(
    input clk,
    input we,                   // write enable
    input [3:0] read_reg1,
    input [3:0] read_reg2,
    input [3:0] write_reg,
    input [15:0] write_data,
    output [15:0] read_data1,
    output [15:0] read_data2
);

reg [15:0] reg_file [0:15];  // 16 registers

assign read_data1 = reg_file[read_reg1];
assign read_data2 = reg_file[read_reg2];

always @(posedge clk) begin
    if (we)
        reg_file[write_reg] <= write_data;
end

endmodule
