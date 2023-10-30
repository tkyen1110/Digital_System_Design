module MEM_WB (
    clk_i,
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    ALU_result_i,
    MemData_i,
    RDaddr_i,
    MemStall_i,

    RegWrite_o,
    MemtoReg_o,
    ALU_result_o,
    MemData_o,
    RDaddr_o
);

input                       clk_i, rst_i;
input                       RegWrite_i;
input                       MemtoReg_i;
input signed        [31:0]  ALU_result_i;
input signed        [31:0]  MemData_i;
input               [4:0]   RDaddr_i;
input                       MemStall_i;

output reg                  RegWrite_o;
output reg                  MemtoReg_o;
output reg signed   [31:0]  ALU_result_o;
output reg signed   [31:0]  MemData_o;
output reg          [4:0]   RDaddr_o;

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i == 1) begin
        RegWrite_o <= 0;
        MemtoReg_o <= 0;
        ALU_result_o <= 0;
        MemData_o <= 0;
        RDaddr_o <= 0;
    end
    else if (~MemStall_i) begin
        RegWrite_o <= RegWrite_i;
        MemtoReg_o <= MemtoReg_i;
        ALU_result_o <= ALU_result_i;
        MemData_o <= MemData_i;
        RDaddr_o <= RDaddr_i;
    end
end

endmodule