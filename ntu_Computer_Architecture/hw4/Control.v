module Control
(
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input   [6:0]       Op_i;
output  [1:0]       ALUOp_o;
output              ALUSrc_o;
output              RegWrite_o;

reg     [1:0]       ALUOp_o;
reg                 ALUSrc_o;

`define Rtype 2'b01
`define Itype 2'b00

always@(Op_i) begin
    if (Op_i[6:5] == 2'b01)
        begin
            ALUSrc_o = 1'b0;
            ALUOp_o = `Rtype;
        end
    else
        begin
            ALUSrc_o = 1'b1;
            ALUOp_o = `Itype;
        end
end

assign RegWrite_o = 1'b1;

endmodule