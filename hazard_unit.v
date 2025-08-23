module hazard_unit(
    input [3:0] id_ex_rd,   // Destination reg in EX stage
    input [3:0] if_id_rs,   // Source reg 1 in ID stage
    input [3:0] if_id_rt,   // Source reg 2 in ID stage
    input id_ex_mem_read,   // Load instruction flag
    output reg stall,       // Stall signal
    output reg forwardA,    // Forward signal for operand A
    output reg forwardB     // Forward signal for operand B
);

always @(*) begin
    // Default values
    stall = 0;
    forwardA = 0;
    forwardB = 0;

    // Load-use hazard detection
    if (id_ex_mem_read && ((id_ex_rd == if_id_rs) || (id_ex_rd == if_id_rt))) begin
        stall = 1; // Stall pipeline
    end

    // Forwarding logic (simple example)
    if (id_ex_rd != 0 && id_ex_rd == if_id_rs) forwardA = 1;
    if (id_ex_rd != 0 && id_ex_rd == if_id_rt) forwardB = 1;
end

endmodule
