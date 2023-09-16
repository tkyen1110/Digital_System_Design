module ALU_Control (
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input   [9:0]       funct_i;
input   [1:0]       ALUOp_i;
output  [2:0]       ALUCtrl_o;
reg     [2:0]       ALUCtrl_o;

wire    [6:0]       funct7;
wire    [2:0]       funct3;
assign {funct7, funct3} = funct_i;

`define Rtype 2'b01
`define Itype 2'b00

`define AND 10'b0000000111
`define XOR 10'b0000000100
`define SLL 10'b0000000001
`define ADD 10'b0000000000
`define SUB 10'b0100000000
`define MUL 10'b0000001000
`define ADDI 3'b000
`define SRAI 3'b101

`define ANDo 3'b000
`define XORo 3'b001
`define SLLo 3'b010
`define ADDo 3'b011
`define SUBo 3'b100
`define MULo 3'b101
`define ADDIo 3'b110
`define SRAIo 3'b111

always @* begin
    if (ALUOp_i == `Itype) begin
        case (funct3)
            `ADDI: ALUCtrl_o = `ADDIo;
            `SRAI: ALUCtrl_o = `SRAIo;
        endcase
    end
    else begin
        case (funct_i)
            `AND: ALUCtrl_o = `ANDo;
            `XOR: ALUCtrl_o = `XORo;
            `SLL: ALUCtrl_o = `SLLo;
            `ADD: ALUCtrl_o = `ADDo;
            `SUB: ALUCtrl_o = `SUBo;
            `MUL: ALUCtrl_o = `MULo;
        endcase
    end
end
endmodule