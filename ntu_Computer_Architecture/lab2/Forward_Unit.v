module Forward_Unit(
    MEM_RegWrite_i,
    MEM_RDaddr_i,
    WB_RegWrite_i,
    WB_RDaddr_i,
    EX_RS1addr_i,
    EX_RS2addr_i,
    ForwardA_o,
    ForwardB_o
);

input           MEM_RegWrite_i, WB_RegWrite_i;
input   [4:0]   MEM_RDaddr_i, WB_RDaddr_i, EX_RS1addr_i, EX_RS2addr_i;
output  [1:0]   ForwardA_o, ForwardB_o;

assign ForwardA_o = (MEM_RegWrite_i && MEM_RDaddr_i != 0 && MEM_RDaddr_i == EX_RS1addr_i)? 2'b10:
                    (WB_RegWrite_i && WB_RDaddr_i != 0 && WB_RDaddr_i == EX_RS1addr_i)? 2'b01: 2'b00;

assign ForwardB_o = (MEM_RegWrite_i && MEM_RDaddr_i != 0 && MEM_RDaddr_i == EX_RS2addr_i)? 2'b10:
                    (WB_RegWrite_i && WB_RDaddr_i != 0 && WB_RDaddr_i == EX_RS2addr_i)? 2'b01: 2'b00;

endmodule