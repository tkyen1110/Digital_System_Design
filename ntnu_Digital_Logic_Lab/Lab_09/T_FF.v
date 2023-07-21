module T_FF(output Q, input T, Clk, rst);
wire D;
assign D = Q^T;
D_FF DF1(Q, D, Clk, rst);

endmodule