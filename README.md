# 8-bit ALU Verilog

This repository contains an 8-bit ALU module (`Alu.v`) and a testbench (`alu_tb.v`) written in Verilog.

## Operations Supported
- ADD, ADD with Carry (ADC)
- SUB, INC, DEC
- AND, NOT
- ROL, ROR
- Invalid opcode detection

## Flags
- `Car_out` : Carry output for addition/increment
- `Borrow`  : Borrow output for subtraction/decrement
- `Zero`    : Set when result `Y` is 0
- `Parity`  : XOR of all bits in `Y`
- `Invalid_op` : Set when an unsupported opcode is used

## Testbench
The testbench `alu_tb.v` simulates all operations with the following inputs:

| Operation | A      | B      | car_in | Y      | Car_out | Borrow | Zero | Parity | Invalid_op |
|-----------|--------|--------|--------|--------|---------|--------|------|--------|------------|
| ADD       | 10     | 5      | 0      | 15     | 0       | 0      | 0    | 0      | 0          |
| ADC       | 200    | 100    | 1      | 45     | 1       | 0      | 0    | 0      | 0          |
| SUB       | 5      | 10     | 0      | 251    | 0       | 1      | 0    | 0      | 0          |
| INC       | 255    | 0      | 0      | 0      | 1       | 0      | 1    | 0      | 0          |
| DEC       | 0      | 0      | 0      | 255    | 0       | 1      | 0    | 0      | 0          |
| AND       | 10101010| 01010101| 0      | 00000000| 0       | 0      | 1    | 0      | 0          |
| NOT       | 10101010| 0      | 0      | 01010101| 0       | 0      | 0    | 0      | 0          |
| ROL       | 10011001| 0      | 0      | 00110011| 0       | 0      | 0    | 0      | 0          |
| ROR       | 10011001| 0      | 0      | 11001100| 0       | 0      | 0    | 0      | 0          |
| INVALID   | 0      | 0      | 0      | 0      | 0       | 0      | 1    | 0      | 1          |

## Usage
- Run simulation using Icarus Verilog or ModelSim.
- Observe outputs using `$display` statements in `alu_tb.v` or waveform viewer (`.vcd` file).

