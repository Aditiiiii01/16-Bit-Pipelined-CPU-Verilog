module alu(
    input [15:0] a, b,
    input [3:0] alu_control,
    output reg [15:0] result,
    output zero
);

assign zero = (result == 16'b0);

always @(*) begin
    case(alu_control)
        4'b0000: result = a + b;     // ADD
        4'b0001: result = a - b;     // SUB
        4'b0010: result = a & b;     // AND
        4'b0011: result = a | b;     // OR
        4'b0100: result = a ^ b;     // XOR
        4'b0101: result = ~a;        // NOT
        4'b0110: result = a << 1;    // Shift Left
        4'b0111: result = a >> 1;    // Shift Right
        default: result = 16'b0;
    endcase
end

endmodule
