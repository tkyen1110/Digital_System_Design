module Priority_Encoder_8to3(Din, Dout, Valid);
input [7:0] Din;
output [2:0] Dout;
output Valid;
wire [1:0] Dout_1, Dout_0;
wire Valid_1, Valid_0;

Priority_Encoder_4to2 PENC4_1(.Din(Din[7:4]), .Dout(Dout_1), .Valid(Valid_1));
Priority_Encoder_4to2 PENC4_0(.Din(Din[3:0]), .Dout(Dout_0), .Valid(Valid_0));

assign Dout[1:0] = Valid_1 ? Dout_1 : Dout_0;
assign Dout[2] = Valid_1;
assign Valid = Valid_1 | Valid_0;

endmodule