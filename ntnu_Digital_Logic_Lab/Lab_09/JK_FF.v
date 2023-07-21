module JK_FF(output Q, input J, K, Clk, rst);
wire D;
assign D = (J&~Q)|(~K&Q);
D_FF DF1(Q, D, Clk, rst);

endmodule