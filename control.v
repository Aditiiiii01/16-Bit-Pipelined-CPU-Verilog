module control(
    input [3:0] opcode,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg [3:0] alu_op
);

always @(*) begin
    case(opcode)
        4'b0000: begin reg_write = 1; mem_read=0; mem_write=0; alu_op=4'b0000; end // ADD
        4'b0001: begin reg_write = 1; mem_read=0; mem_write=0; alu_op=4'b0001; end // SUB
        4'b0010: begin reg_write = 1; mem_read=0; mem_write=0; alu_op=4'b0010; end // AND
        4'b0011: begin reg_write = 1; mem_read=0; mem_write=0; alu_op=4'b0011; end // OR
        default: begin reg_write=0; mem_read=0; mem_write=0; alu_op=4'b0000; end
    endcase
end

endmodule
