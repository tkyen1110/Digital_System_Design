module D_FF_8_bit(Din, reset, w_en, clk, Dout);
input[7:0] Din;
input reset, w_en, clk;
output[7:0] Dout;
reg[7:0] Dout;

always @(posedge clk, negedge reset)
	if (!reset)
		Dout <= 8'b00000000;
	else
		Dout <= w_en ? Din : Dout;

endmodule