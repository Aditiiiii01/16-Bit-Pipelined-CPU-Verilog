# 16-bit Pipelined CPU in Verilog

This project implements a **16-bit 5-stage pipelined CPU** in Verilog, designed as an educational tool to understand the working of pipelined processor architectures. It features hazard detection, forwarding, pipeline registers, a basic ALU, and memory modules.



## Features

- **5-Stage Pipeline**: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory (MEM), Write Back (WB)  
- **Hazard Detection & Forwarding**: Handles data hazards efficiently  
- **Pipeline Registers**: IF/ID, ID/EX, EX/MEM, MEM/WB for smooth instruction flow  
- **ALU**: Supports arithmetic and logical operations  
- **Register File**: Read/write operations for CPU registers  
- **Instruction & Data Memory**: Basic modules to store instructions and data  
- **Testbench**: Verify functionality and simulate CPU behavior



## Architecture Diagram

![CPU Architecture Diagram](https://shashisuman.wordpress.com/wp-content/uploads/2020/06/7d003-datapath2b252812529.jpg)

*Source: [Shashi Suman's Blog](https://shashisuman.wordpress.com/2019/05/11/verilog-code-for-16-bit-mips-pipelined-processor/)*



## Getting Started

### Prerequisites

- Verilog simulator (e.g., ModelSim, Vivado)

### Simulation Steps

1. Open `cpu_tb.v` in your Verilog simulator  
2. Compile all Verilog source files  
3. Run the simulation to observe CPU operation  

### File Structure

| File | Description |
|------|-------------|
| `cpu.v` | Top-level CPU module |
| `cpu_tb.v` | Testbench for simulation |
| `alu.v` | Arithmetic Logic Unit |
| `control.v` | Control Unit |
| `hazard_unit.v` | Hazard detection and forwarding unit |
| `registers.v` | CPU register file |
| `IF_ID.v`, `ID_EX.v`, `EX_MEM.v`, `MEM_WB.v` | Pipeline registers |
| `README.md` | Project documentation |



## How It Works

1. **Instruction Fetch (IF)**: Fetches instruction from memory  
2. **Instruction Decode (ID)**: Decodes instruction and reads registers  
3. **Execute (EX)**: ALU performs calculations or address computations  
4. **Memory Access (MEM)**: Reads/writes data from/to memory  
5. **Write Back (WB)**: Writes results back to register file  

Hazard detection and forwarding ensure smooth pipeline operation without data conflicts.


## Acknowledgments

- [Shashi Suman's Blog](https://shashisuman.wordpress.com/2019/05/11/verilog-code-for-16-bit-mips-pipelined-processor/) for inspiration and architecture diagram  
- [Akeel Medina's RISC-V Pipelined Processor](https://github.com/AkeelMedina22/RISC-V-Pipelined-Processor) for ideas on pipelined CPU design

