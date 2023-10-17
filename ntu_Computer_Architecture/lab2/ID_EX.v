module ID_EX (
    clk_i,
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALUOp_i,
    ALUSrc_i,
    RS1data_i,
    RS2data_i,
    Imm_i,
    ALUfunct_i,
    RS1addr_i,
    RS2addr_i,
    RDaddr_i,

    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    RS1data_o,
    RS2data_o,
    Imm_o,
    ALUfunct_o,
    RS1addr_o,
    RS2addr_o,
    RDaddr_o
);

input               clk_i, rst_i;
input               RegWrite_i;
input               MemtoReg_i;
input               MemRead_i;
input               MemWrite_i;
input               [1:0] ALUOp_i;
input               ALUSrc_i;
input signed        [31:0] RS1data_i;
input signed        [31:0] RS2data_i;
input signed        [31:0] Imm_i;
input               [9:0] ALUfunct_i;
input               [4:0] RS1addr_i;
input               [4:0] RS2addr_i;
input               [4:0] RDaddr_i;

output reg          RegWrite_o;
output reg          MemtoReg_o;
output reg          MemRead_o;
output reg          MemWrite_o;
output reg          [1:0] ALUOp_o;
output reg          ALUSrc_o;
output reg signed   [31:0] RS1data_o;
output reg signed   [31:0] RS2data_o;
output reg signed   [31:0] Imm_o;
output reg          [9:0] ALUfunct_o;
output reg          [4:0] RS1addr_o;
output reg          [4:0] RS2addr_o;
output reg          [4:0] RDaddr_o;

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i == 1) begin
        RegWrite_o <= 0;
        MemtoReg_o <= 0;
        MemRead_o <= 0;
        MemWrite_o <= 0;
        ALUOp_o <= 0;
        ALUSrc_o <= 0;
        RS1data_o <= 0;
        RS2data_o <= 0;
        Imm_o <= 0;
        ALUfunct_o <= 0;
        RS1addr_o <= 0;
        RS2addr_o <= 0;
        RDaddr_o <= 0;
    end
    else begin
        RegWrite_o <= RegWrite_i;
        MemtoReg_o <= MemtoReg_i;
        MemRead_o <= MemRead_i;
        MemWrite_o <= MemWrite_i;
        ALUOp_o <= ALUOp_i;
        ALUSrc_o <= ALUSrc_i;
        RS1data_o <= RS1data_i;
        RS2data_o <= RS2data_i;
        Imm_o <= Imm_i;
        ALUfunct_o <= ALUfunct_i;
        RS1addr_o <= RS1addr_i;
        RS2addr_o <= RS2addr_i;
        RDaddr_o <= RDaddr_i;
    end
end

endmodule