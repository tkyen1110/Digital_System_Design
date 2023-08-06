module Shift_Register_SISO_SIPO_Display(btn, clk, reset, SW, Din, Sout, Pout);
input btn, clk, reset, SW, Din;
output Sout;
output[7:0] Pout;
wire SR_clk;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(SR_clk));
Shift_Register_SISO_SIPO SR(.clk(SR_clk), .reset(reset), .SW(SW), .Din(Din), .Sout(Sout), .Pout(Pout));

endmodule