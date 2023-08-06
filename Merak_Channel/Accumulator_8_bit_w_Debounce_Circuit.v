module Accumulator_8_bit_w_Debounce_Circuit(btn, clk, reset, Sout1, Sout0);
input btn, clk, reset;
output[6:0] Sout1, Sout0;

wire Acc_clk;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(Acc_clk));
Accumulator_8_bit Acc8(.reset(reset), .w_en(1'b1), .clk(Acc_clk), .Sout1(Sout1), .Sout0(Sout0));

endmodule