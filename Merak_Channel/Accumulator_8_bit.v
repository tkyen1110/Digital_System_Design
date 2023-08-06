module Accumulator_8_bit(reset, w_en, clk, Sout1, Sout0);
input reset, w_en, clk;
output[6:0] Sout1, Sout0;

wire[7:0] Din, Dout;

// assign Din = Dout + 8'd1;
Carry_Lookahead_Adder_8_bit CLA8(.A(Dout), .B(8'd1), .Cin(1'b0), .S(Din), .Cout());

D_FF_8_bit DFF8(.Din(Din), .reset(reset), .w_en(w_en), .clk(clk), .Dout(Dout));
Seven_Segment Seg1(.Din(Dout[7:4]), .Dout(Sout1));
Seven_Segment Seg0(.Din(Dout[3:0]), .Dout(Sout0));

endmodule