module Frequency_Divider(Fin, Fsel, Fout);
input Fin;
input[2:0] Fsel;
output Fout;
reg Fout;

wire[31:0] Dout, Dout_h, Acc_out;
wire reset, F_t;

assign Dout_h = {1'b0, Dout[31:1]};
assign reset = (Acc_out >= Dout - 1'b1);
assign F_t = (Acc_out >= Dout_h);

Frequency_Divider_Decoder DivDec(.Din(Fsel), .Dout(Dout));
Accumulator_32_bit Acc32(.reset(reset), .w_en(1'b1), .clk(Fin), .Acc_out(Acc_out));

always@(posedge Fin)
	Fout <= F_t;

endmodule