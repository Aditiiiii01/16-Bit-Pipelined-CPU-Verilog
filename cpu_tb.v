`timescale 1ns/1ps

module cpu_tb();

    reg clk;
    reg reset;

    // Instantiate the CPU
    cpu myCPU(
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        #10;
        reset = 0;

        // Load instructions into instruction memory
        // Example: simple instructions (opcode + rs + rt + rd)
        // opcode: 4 bits, rs:4, rt:4, rd:4
        myCPU.instr_mem[0] = 16'b0001_0001_0010_0011; // ADD r1, r2 -> r3
        myCPU.instr_mem[1] = 16'b0010_0011_0100_0101; // SUB r3, r4 -> r5
        myCPU.instr_mem[2] = 16'b0100_0101_0110_0111; // AND r5, r6 -> r7
        myCPU.instr_mem[3] = 16'b0110_0111_1000_1001; // OR r7, r8 -> r9

        // Run simulation for some cycles
        #200;

        $stop;
    end

endmodule
