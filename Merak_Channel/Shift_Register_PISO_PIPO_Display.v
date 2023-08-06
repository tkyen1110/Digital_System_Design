module Shift_Register_PISO_PIPO_Display(btn, clk, reset, SW, PS, Sin, Pin, Sout, Pout);
input btn, clk, reset, SW, PS, Sin;
input[7:1] Pin;
output Sout;
output[7:0] Pout;
wire SR_clk;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(SR_clk));
Shift_Register_PISO_PIPO SR(.clk(SR_clk), .reset(reset), .SW(SW), .PS(PS), .Sin(Sin), .Pin({Pin, Sin}), .Sout(Sout), .Pout(Pout));

endmodule