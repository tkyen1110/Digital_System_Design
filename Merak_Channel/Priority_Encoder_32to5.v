module Priority_Encoder_32to5(Din, Dout, Valid);
input [31:0] Din;
output [4:0] Dout;
output Valid;
wire [3:0] Dout_1, Dout_0;
wire Valid_1, Valid_0;

Priority_Encoder_16to4 PENC4_1(.Din(Din[31:16]), .Dout(Dout_1), .Valid(Valid_1));
Priority_Encoder_16to4 PENC4_0(.Din(Din[15:0]), .Dout(Dout_0), .Valid(Valid_0));

assign Dout[3:0] = Valid_1 ? Dout_1 : Dout_0;
assign Dout[4] = Valid_1;
assign Valid = Valid_1 | Valid_0;

endmodule