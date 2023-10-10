// opcode
`define Rtype_op_code   7'b0110011
`define Itype_op_code   7'b0010011
`define Load_op_code    7'b0000011
`define Store_op_code   7'b0100011
`define Branch_op_code  7'b1100011

// func3
`define ADDI_func3      3'b000
`define SRAI_func3      3'b101
`define LW_func3        3'b010
`define SW_func3        3'b010
`define BEQ_func3       3'b000

// ALUOp
`define Rtype_ALUop 2'b10
`define Itype_ALUop 2'b00
`define LS_ALUop    2'b00
`define BEQ_ALUop   2'b01

// ALU control input
`define AND         4'b0000 // 0
`define XOR         4'b0111 // 7
`define SLL         4'b0011 // 3
`define ADD         4'b0010 // 2
`define SUB         4'b0110 // 6
`define MUL         4'b1000 // 8
`define SRAI        4'b1001 // 9

// funct3
`define ADDI_f3 3'b000
`define SRAI_f3 3'b101
`define LS_f3   3'b010