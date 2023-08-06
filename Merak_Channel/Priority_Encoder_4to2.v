module Priority_Encoder_4to2(Din, Dout, Valid);
input [3:0] Din;
output [1:0] Dout;
output Valid;

assign Dout[1] = Din[3] | Din[2];
assign Dout[0] = Din[3] | (Din[1] & (!Din[2]));
assign Valid = |Din;

endmodule