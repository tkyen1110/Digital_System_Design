module Sign_Extend (
    data_i,
    data_o
);

input signed        [31:0]  data_i;
output reg signed   [31:0]  data_o;

wire    [6:0]               opcode;
wire    [2:0]               func3;
assign opcode = data_i[6:0];
assign func3 = data_i[14:12];

always @(data_i) begin
    case (opcode)
        `Itype_op_code:
            begin
                case (func3)
                    `ADDI_func3:
                        data_o <= {{20{data_i[31]}}, data_i[31:20]};
                    `SRAI_func3:
                        data_o <= {{27{data_i[24]}}, data_i[24:20]};
                    default:
                        data_o <= 32'b0;
                endcase
            end
        `Load_op_code:
            begin
                case (func3)
                    `LW_func3:
                        data_o <= {{20{data_i[31]}}, data_i[31:20]};
                    default:
                        data_o <= 32'b0;
                endcase
            end
        `Store_op_code:
            begin
                case (func3)
                    `SW_func3:
                        data_o <= {{20{data_i[31]}}, data_i[31:25], data_i[11:7]};
                    default:
                        data_o <= 32'b0;
                endcase
            end
        `Branch_op_code:
            begin
                case (func3)
                    `BEQ_func3:
                        data_o <= {{20{data_i[31]}}, data_i[31], data_i[7], data_i[30:25], data_i[11:8]};
                    default:
                        data_o <= 32'b0;
                endcase
            end
        default:
            data_o <= 32'b0;
    endcase
end

endmodule