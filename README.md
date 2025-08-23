# 16-bit Pipelined CPU in Verilog

## Overview
This project implements a 16-bit pipelined CPU (5-stage) in Verilog with hazard detection and forwarding, IF/ID, ID/EX, EX/MEM, MEM/WB pipeline registers, ALU, register file, and control unit. It supports arithmetic, logical, load, store, and branch instructions, demonstrating RTL design, pipeline hazards, forwarding, and verification using Verilog testbenches.

## Repository Structure

rtl/ # Verilog modules: ALU, control unit, registers, pipeline stages, CPU top module
tb/ # Testbenches for CPU and submodules
docs/ # Documentation: pipeline diagrams, screenshots, and design notes

## Simulation Instructions
### Using ModelSim
1. Open ModelSim and create a new project.
2. Add all files from rtl/ and tb/.
3. Compile all files, ensuring there are no compilation errors.
4. Set cpu_tb as the top-level module.
5. Run the simulation:
   vsim cpu_tb
   run 300ns
6. Observe signals using the waveform viewer: PC, pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB), ALU outputs, and register file.
7. `$monitor` statements in the testbench also print key values in the console for debugging.

### Using Quartus II Simulator
1. Open Quartus II and create a new project.
2. Add all RTL files (rtl/) and testbench files (tb/).
3. Set cpu_tb as the top-level entity.
4. Compile the project and run Functional Simulation.
5. Observe waveforms for pipeline registers, ALU, and registers.

### Using Libero Project Manager
1. Open Libero Project Manager and create a new project.
2. Add all RTL modules (rtl/) and testbench files (tb/).
3. Set cpu_tb as the top-level module for simulation.
4. Compile and run functional simulation.
5. Open waveform viewer to inspect pipeline stages, forwarding behavior, and register updates.

## Pipeline Diagram
A pipeline diagram illustrating the 5 stages (IF → ID → EX → MEM → WB) is included in docs/.
- IF: Instruction Fetch
- ID: Instruction Decode & Register Read
- EX: Execute / ALU operations
- MEM: Memory access
- WB: Write Back to register file

## Author
Aditi Vishal Paunikar
- B.Tech - Electrical Engineering, NIT Agartala
- GitHub: https://github.com/Aditiiiii01/16-Bit-Pipelined-CPU-Verilog

## Notes
- Ensure reset is asserted at the start for proper initialization.
- Modify instruction memory in the testbench to test different hazard and branch scenarios.
- Use waveforms and console outputs together for full verification coverage.
- **Testing**: Run the testbenches in tb/ to verify functionality.
- **Known Issues**: No known issues at this time.
- **Future Work**: Plan to implement support for additional instructions and optimizations.
