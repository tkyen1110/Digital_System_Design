module Priority_Encoder_16to4(Din, Dout, Valid);
input [15:0] Din;
output [3:0] Dout;
output Valid;
wire [2:0] Dout_1, Dout_0;
wire Valid_1, Valid_0;

Priority_Encoder_8to3 PENC8_1(.Din(Din[15:8]), .Dout(Dout_1), .Valid(Valid_1));
Priority_Encoder_8to3 PENC8_0(.Din(Din[7:0]), .Dout(Dout_0), .Valid(Valid_0));

assign Dout[2:0] = Valid_1 ? Dout_1 : Dout_0;
assign Dout[3] = Valid_1;
assign Valid = Valid_1 | Valid_0;

endmodule