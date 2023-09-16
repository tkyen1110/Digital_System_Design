module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

wire    [31:0]      pc_i, pc_o, instruction;
wire    [31:0]      RS1_result, RS2_result, ALU_result;
wire    [1:0]       ALUOp;
wire                ALUSrc, RegWrite;
wire    [31:0]      sign_extend, mux_o;
wire    [2:0]       ALUCtrl;
wire                Zero;


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);


Adder Add_PC(
    .data1_in   (pc_o),
    .data2_in   (32'b0100),
    .data_o     (pc_i)
);


Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o),
    .instr_o    (instruction)
);


Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i  (instruction[19:15]),
    .RS2addr_i  (instruction[24:20]),
    .RDaddr_i   (instruction[11:7]),
    .RDdata_i   (ALU_result),
    .RegWrite_i (RegWrite),
    .RS1data_o  (RS1_result),
    .RS2data_o  (RS2_result)
);


Control Control(
    .Op_i       (instruction[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);


Sign_Extend Sign_Extend(
    .data_i     (instruction[31:20]),
    .data_o     (sign_extend)
);


MUX32 MUX_ALUSrc(
    .data1_i    (RS2_result),
    .data2_i    (sign_extend),
    .select_i   (ALUSrc),
    .data_o     (mux_o)
);


ALU_Control ALU_Control(
    .funct_i    ({instruction[31:25], instruction[14:12]}),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);


ALU ALU(
    .data1_i    (RS1_result),
    .data2_i    (mux_o),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (ALU_result),
    .Zero_o     (Zero)
);

endmodule

