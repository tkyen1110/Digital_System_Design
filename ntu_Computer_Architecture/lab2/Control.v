`include "./defs.v"
module Control
(
    Op_i,
    NoOp_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    Branch_o
);
//              ALUOp_o     ALUSrc_o    Branch_o    MemRead_o   MemWrite_o  RegWrite_o  MemtoReg_o
// R-format     10          0           0           0           0           1           0
// I-format     00          1           0           0           0           1           0
//       lw     00          1           0           1           0           1           1
//       sw     00          1           0           0           1           0           X
//      beq     01          0           1           0           0           0           X

// Ports
input       [6:0]   Op_i;
input               NoOp_i;
output reg          RegWrite_o, MemtoReg_o, MemRead_o, MemWrite_o, ALUSrc_o, Branch_o;
output reg  [1:0]   ALUOp_o;

always @(Op_i, NoOp_i) begin
    if (Op_i == 7'b0 || NoOp_i == 1'b1) begin
        RegWrite_o <= 1'b0;
        MemtoReg_o <= 1'b0;
        MemRead_o <= 1'b0;
        MemWrite_o <= 1'b0;
        ALUOp_o <= 2'b00;
        ALUSrc_o <= 1'b0;
        Branch_o <= 1'b0;
    end
    else begin
        case (Op_i)
            `Rtype_op_code: begin
                RegWrite_o <= 1'b1;
                MemtoReg_o <= 1'b0;
                MemRead_o  <= 1'b0;
                MemWrite_o <= 1'b0;
                ALUOp_o    <= `Rtype_ALUop;
                ALUSrc_o   <= 1'b0;
                Branch_o   <= 1'b0;
            end
            `Itype_op_code: begin
                RegWrite_o <= 1'b1;
                MemtoReg_o <= 1'b0;
                MemRead_o  <= 1'b0;
                MemWrite_o <= 1'b0;
                ALUOp_o    <= `Itype_ALUop;
                ALUSrc_o   <= 1'b1;
                Branch_o   <= 1'b0;
            end
            `Load_op_code: begin
                RegWrite_o <= 1'b1;
                MemtoReg_o <= 1'b1;
                MemRead_o  <= 1'b1;
                MemWrite_o <= 1'b0;
                ALUOp_o    <= `LS_ALUop;
                ALUSrc_o   <= 1'b1;
                Branch_o   <= 1'b0;
            end
            `Store_op_code: begin
                RegWrite_o <= 1'b0;
                MemtoReg_o <= 1'bX;
                MemRead_o  <= 1'b0;
                MemWrite_o <= 1'b1;
                ALUOp_o    <= `LS_ALUop;
                ALUSrc_o   <= 1'b1;
                Branch_o   <= 1'b0;
            end
            `Branch_op_code: begin
                RegWrite_o <= 1'b0;
                MemtoReg_o <= 1'bX;
                MemRead_o  <= 1'b0;
                MemWrite_o <= 1'b0;
                ALUOp_o    <= `BEQ_ALUop;
                ALUSrc_o   <= 1'b0;
                Branch_o   <= 1'b1;
            end
        endcase
    end
end

endmodule