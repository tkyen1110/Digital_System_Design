module Add6(Din, Dout, Cout);
input[3:0] Din;
output[3:0] Dout;
output Cout;

assign Dout[0] = Din[0];
assign Dout[1] = !Din[1];
assign Dout[2] = (Din[1])^(!Din[2]);
assign Dout[3] = (Din[1] | Din[2])^(Din[3]);

assign Cout = (Din[1] | Din[2]) & Din[3];

endmodule