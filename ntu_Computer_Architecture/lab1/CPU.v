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

// Instruction Fetch (IF)
wire                PCWrite;
wire    [31:0]      PC_Add4, MUX_PC, IF_PC,  IF_Instr;

// Instruction Decode (ID)
wire                Stall, Flush;
wire    [31:0]      ID_PC, ID_Instr;
wire    [31:0]      ID_RS1, ID_RS2;
wire                NoOp, ID_RegWrite, ID_MemtoReg, ID_MemRead, ID_MemWrite, ID_ALUSrc, Branch;
wire    [1:0]       ID_ALUOp;
wire    [31:0]      ID_Imm;
wire    [31:0]      PC_Branch;

// Execution (EX)
wire                EX_RegWrite, EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_ALUSrc;
wire    [1:0]       EX_ALUOp;
wire    [31:0]      EX_RS1, EX_RS2, EX_Imm;
wire    [4:0]       EX_RS1addr, EX_RS2addr, EX_RDaddr;
wire    [9:0]       EX_ALUfunct;
wire    [1:0]       ForwardA, ForwardB;
wire    [31:0]      MUX_ForwardA, MUX_ForwardB, MUX_ALUSrc;
wire    [3:0]       ALUCtrl;
wire    [31:0]      EX_ALU_result;

// Memory Access (MEM)
wire                MEM_RegWrite, MEM_MemtoReg, MEM_MemRead, MEM_MemWrite;
wire    [31:0]      MEM_ALU_result, MEM_WriteData, MEM_ReadData;
wire    [4:0]       MEM_RDaddr;

// Write Back (WB)
wire                WB_RegWrite, WB_MemtoReg;
wire    [31:0]      WB_ALU_result, WB_ReadData;
wire    [4:0]       WB_RDaddr;
wire    [31:0]      WB_WriteData;


// Instruction Fetch (IF)
MUX2to1 MUX2to1_PC(
    .data1_i    (PC_Add4),
    .data2_i    (PC_Branch),
    .select_i   (Flush),
    .data_o     (MUX_PC)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .PCWrite_i  (PCWrite),
    .pc_i       (MUX_PC),
    .pc_o       (IF_PC)
);

Adder Add_PC(
    .data1_in   (IF_PC),
    .data2_in   (32'b0100),
    .data_o     (PC_Add4)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (IF_PC),
    .instr_o    (IF_Instr)
);

// IF_ID Register
IF_ID IF_ID(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .pc_i       (IF_PC),
    .instr_i    (IF_Instr),
    .stall_i    (Stall),
    .flush_i    (Flush),
    .pc_o       (ID_PC),
    .instr_o    (ID_Instr)
);

// Instruction Decode (ID)
Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i  (ID_Instr[19:15]),
    .RS2addr_i  (ID_Instr[24:20]),
    .RDaddr_i   (WB_RDaddr),
    .RDdata_i   (WB_WriteData),
    .RegWrite_i (WB_RegWrite),
    .RS1data_o  (ID_RS1),
    .RS2data_o  (ID_RS2)
);

assign Flush = (Branch && (ID_RS1 == ID_RS2));

Control Control(
    .Op_i       (ID_Instr[6:0]),
    .NoOp_i     (NoOp),
    .RegWrite_o (ID_RegWrite),
    .MemtoReg_o (ID_MemtoReg),
    .MemRead_o  (ID_MemRead),
    .MemWrite_o (ID_MemWrite),
    .ALUOp_o    (ID_ALUOp),
    .ALUSrc_o   (ID_ALUSrc),
    .Branch_o   (Branch)
);

Sign_Extend Sign_Extend(
    .data_i     (ID_Instr[31:0]),
    .data_o     (ID_Imm)
);

Adder Add_Branch(
    .data1_in   (ID_Imm << 1),
    .data2_in   (ID_PC),
    .data_o     (PC_Branch)
);

Hazard_Detection Hazard_Detection(
    .EX_MemRead_i   (EX_MemRead),
    .EX_RDaddr_i    (EX_RDaddr),
    .ID_RS1addr_i   (ID_Instr[19:15]),
    .ID_RS2addr_i   (ID_Instr[24:20]),
    .PCWrite_o      (PCWrite),
    .Stall_o        (Stall),
    .NoOp_o         (NoOp)
);

// ID_EX Register
ID_EX ID_EX(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .RegWrite_i (ID_RegWrite),
    .MemtoReg_i (ID_MemtoReg),
    .MemRead_i  (ID_MemRead),
    .MemWrite_i (ID_MemWrite),
    .ALUOp_i    (ID_ALUOp),
    .ALUSrc_i   (ID_ALUSrc),
    .RS1data_i  (ID_RS1),
    .RS2data_i  (ID_RS2),
    .Imm_i      (ID_Imm),
    .ALUfunct_i ({ID_Instr[31:25], ID_Instr[14:12]}),
    .RS1addr_i  (ID_Instr[19:15]),
    .RS2addr_i  (ID_Instr[24:20]),
    .RDaddr_i   (ID_Instr[11:7]),
    .RegWrite_o (EX_RegWrite),
    .MemtoReg_o (EX_MemtoReg),
    .MemRead_o  (EX_MemRead),
    .MemWrite_o (EX_MemWrite),
    .ALUOp_o    (EX_ALUOp),
    .ALUSrc_o   (EX_ALUSrc),
    .RS1data_o  (EX_RS1),
    .RS2data_o  (EX_RS2),
    .Imm_o      (EX_Imm),
    .ALUfunct_o (EX_ALUfunct),
    .RS1addr_o  (EX_RS1addr),
    .RS2addr_o  (EX_RS2addr),
    .RDaddr_o   (EX_RDaddr)
);

// Execution (EX)
MUX4to1 MUX4to1_ForwardA(
    .data1_i    (EX_RS1),
    .data2_i    (WB_WriteData),
    .data3_i    (MEM_ALU_result),
    .data4_i    (32'b0),
    .select_i   (ForwardA),
    .data_o     (MUX_ForwardA)
);

MUX4to1 MUX4to1_ForwardB(
    .data1_i    (EX_RS2),
    .data2_i    (WB_WriteData),
    .data3_i    (MEM_ALU_result),
    .data4_i    (32'b0),
    .select_i   (ForwardB),
    .data_o     (MUX_ForwardB)
);

MUX2to1 MUX2to1_ALUSrc(
    .data1_i    (MUX_ForwardB),
    .data2_i    (EX_Imm),
    .select_i   (EX_ALUSrc),
    .data_o     (MUX_ALUSrc)
);

ALU_Control ALU_Control(
    .funct_i    (EX_ALUfunct),
    .ALUOp_i    (EX_ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);

ALU ALU(
    .data1_i    (MUX_ForwardA),
    .data2_i    (MUX_ALUSrc),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (EX_ALU_result)
);

Forward_Unit Forward_Unit(
    .MEM_RegWrite_i      (MEM_RegWrite),
    .MEM_RDaddr_i        (MEM_RDaddr),
    .WB_RegWrite_i       (WB_RegWrite),
    .WB_RDaddr_i         (WB_RDaddr),
    .EX_RS1addr_i        (EX_RS1addr),
    .EX_RS2addr_i        (EX_RS2addr),
    .ForwardA_o          (ForwardA),
    .ForwardB_o          (ForwardB)
);

// EX_MEM Register
EX_MEM EX_MEM(
    .clk_i               (clk_i),
    .rst_i               (rst_i),
    .RegWrite_i          (EX_RegWrite),
    .MemtoReg_i          (EX_MemtoReg),
    .MemRead_i           (EX_MemRead),
    .MemWrite_i          (EX_MemWrite),
    .ALU_result_i        (EX_ALU_result),
    .WriteData_i         (MUX_ForwardB),
    .RDaddr_i            (EX_RDaddr),
    .RegWrite_o          (MEM_RegWrite),
    .MemtoReg_o          (MEM_MemtoReg),
    .MemRead_o           (MEM_MemRead),
    .MemWrite_o          (MEM_MemWrite),
    .ALU_result_o        (MEM_ALU_result),
    .WriteData_o         (MEM_WriteData),
    .RDaddr_o            (MEM_RDaddr)
);

// Memory Access (MEM)
Data_Memory Data_Memory(
    .clk_i      (clk_i),
    .addr_i     (MEM_ALU_result),
    .MemRead_i  (MEM_MemRead),
    .MemWrite_i (MEM_MemWrite),
    .data_i     (MEM_WriteData),
    .data_o     (MEM_ReadData)
);

// MEM_WB Register
MEM_WB MEM_WB(
    .clk_i               (clk_i),
    .rst_i               (rst_i),
    .RegWrite_i          (MEM_RegWrite),
    .MemtoReg_i          (MEM_MemtoReg),
    .ALU_result_i        (MEM_ALU_result),
    .MemData_i           (MEM_ReadData),
    .RDaddr_i            (MEM_RDaddr),
    .RegWrite_o          (WB_RegWrite),
    .MemtoReg_o          (WB_MemtoReg),
    .ALU_result_o        (WB_ALU_result),
    .MemData_o           (WB_ReadData),
    .RDaddr_o            (WB_RDaddr)
);

// Write Back (WB)
MUX2to1 MUX_WriteBack(
    .data1_i    (WB_ALU_result),
    .data2_i    (WB_ReadData),
    .select_i   (WB_MemtoReg),
    .data_o     (WB_WriteData)
);

endmodule

