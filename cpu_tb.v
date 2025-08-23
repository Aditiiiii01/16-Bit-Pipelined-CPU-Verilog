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

        // --- Basic arithmetic instructions ---
        myCPU.instr_mem[0] = 16'b0001_0001_0010_0011; // ADD r1, r2 -> r3
        myCPU.instr_mem[1] = 16'b0010_0011_0100_0101; // SUB r3, r4 -> r5

        // --- Data hazard / forwarding example ---
        myCPU.instr_mem[2] = 16'b0100_0101_0110_0111; // AND r5, r6 -> r7
        myCPU.instr_mem[3] = 16'b0001_0111_1000_1001; // ADD r7, r8 -> r9 (depends on previous result)

        // --- Load-use hazard example ---
        myCPU.instr_mem[4] = 16'b1000_0001_0010_0011; // LOAD r1 -> r3
        myCPU.instr_mem[5] = 16'b0001_0011_0100_0101; // ADD r3, r4 -> r5 (uses r3 immediately)

        // --- Branch / control hazard example ---
        myCPU.instr_mem[6] = 16'b1110_0101_0110_0111; // BEQ r5, r6, label (branch)
        myCPU.instr_mem[7] = 16'b0001_0111_1000_1001; // Instruction after branch

        // Run simulation for enough cycles
        #300;

        $stop;
    end

    // Monitor key signals for debugging
    initial begin
        $monitor("Time=%0t | PC=%h | IF/ID=%h | ID/EX=%h | EX/MEM=%h | MEM/WB=%h | Reg1=%h | Reg3=%h",
                  $time,
                  myCPU.pc,
                  myCPU.if_id_instr,
                  myCPU.id_ex_instr,
                  myCPU.ex_mem_instr,
                  myCPU.mem_wb_instr,
                  myCPU.regfile[1],
                  myCPU.regfile[3]);
    end

endmodule
