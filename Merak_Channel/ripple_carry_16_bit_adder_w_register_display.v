module ripple_carry_16_bit_adder_w_register_display(btn, clk, reset, RW, data, addr, read_value, Sout0, Sout1, Sout2, Sout3, add_cout);
input btn, clk, reset, RW;
input[3:0] data;
input[2:0] addr;
output[3:0] read_value;
output[6:0] Sout0, Sout1, Sout2, Sout3;
output add_cout;

wire[15:0] add_sout;
wire DC_out;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(DC_out));
ripple_carry_16_bit_adder_w_register RCA(.clk(DC_out), .reset(reset), .RW(RW), .data(data), .addr(addr), .read_value(read_value), .add_sout(add_sout), .add_cout(add_cout));

Seven_Segment SS0(.Din(add_sout[3:0]), .Dout(Sout0));
Seven_Segment SS1(.Din(add_sout[7:4]), .Dout(Sout1));
Seven_Segment SS2(.Din(add_sout[11:8]), .Dout(Sout2));
Seven_Segment SS3(.Din(add_sout[15:12]), .Dout(Sout3));

endmodule