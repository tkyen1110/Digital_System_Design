module Accumulator_32_bit(reset, w_en, clk, Acc_out);
input reset, w_en, clk;
output[31:0] Acc_out;

wire[31:0] Din;

// assign Din = Acc_out + 32'd1;
Carry_Lookahead_Adder_32_bit CLA32(.A(Acc_out), .B(32'd1), .Cin(1'b0), .S(Din), .Cout());

D_FF_32_bit DFF32(.Din(Din), .reset(reset), .w_en(w_en), .clk(clk), .Dout(Acc_out));

endmodule