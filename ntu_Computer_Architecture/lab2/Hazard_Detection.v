module Hazard_Detection(
    EX_MemRead_i,
    EX_RDaddr_i,
    ID_RS1addr_i,
    ID_RS2addr_i,
    PCWrite_o,
    Stall_o,
    NoOp_o
);

input           EX_MemRead_i;
input [4:0]     EX_RDaddr_i, ID_RS1addr_i, ID_RS2addr_i;
output          PCWrite_o, Stall_o, NoOp_o;

assign PCWrite_o = (EX_MemRead_i == 1 && 
        (EX_RDaddr_i == ID_RS1addr_i || EX_RDaddr_i == ID_RS2addr_i) && EX_RDaddr_i != 0)? 0: 1;

assign Stall_o = !PCWrite_o;
assign NoOp_o = Stall_o;

endmodule