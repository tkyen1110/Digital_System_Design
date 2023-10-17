`include "./defs.v"
module ALU_Control (
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input   [9:0]   funct_i;
input   [1:0]   ALUOp_i;
output  [3:0]   ALUCtrl_o;
reg     [3:0]   ALUCtrl_o;

wire    [6:0]   funct7;
wire    [2:0]   funct3;
assign {funct7, funct3} = funct_i;

always @(*) begin
    case (ALUOp_i)
        2'b00: // I-type, load, store
            case(funct3)
                `ADDI_f3, `LS_f3:
                    ALUCtrl_o <= `ADD;
                `SRAI_f3:
                    ALUCtrl_o <= `SRAI;
            endcase
        2'b01: // beq
            ALUCtrl_o <= `SUB;
        2'b10: //R-type
            case({funct7[5], funct7[0], funct3})
                5'b00111 : ALUCtrl_o <= `AND;
                5'b00100 : ALUCtrl_o <= `XOR;
                5'b00001 : ALUCtrl_o <= `SLL;
                5'b00000 : ALUCtrl_o <= `ADD;
                5'b10000 : ALUCtrl_o <= `SUB;
                5'b01000 : ALUCtrl_o <= `MUL;
            endcase
    endcase
end

endmodule