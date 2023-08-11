module Electronic_Clock_Display(clk, reset, chmode, wen, wdata, Sout3, Sout2, Sout1, Sout0, mode_out);
input clk, reset, chmode, wen;
input[7:0] wdata;
output[6:0] Sout3, Sout2, Sout1, Sout0;
output[2:0] mode_out;

wire[1:0] mode;
wire trigger, clk_1s;
wire[15:0] display_num;
wire[3:0] BCD3, BCD2, BCD1, BCD0;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(chmode), .Dout(trigger));
Mode_Control MC(.trigger(trigger), .reset(reset), .mode(mode));
Frequency_Divider FD(.Fin(clk), .Fsel(3'd3), .Fout(clk_1s));
Electronic_Clock EC(.clk(clk_1s), .reset(reset), .mode(mode), .wen(wen), .wdata(wdata), .display_num(display_num));

Binary_to_BCD BtoBCD1(.Binary(display_num[15:8]), .BCD_2(), .BCD_1(BCD3), .BCD_0(BCD2));
Binary_to_BCD BtoBCD0(.Binary(display_num[7:0]), .BCD_2(), .BCD_1(BCD1), .BCD_0(BCD0));
Seven_Segment SS3(.Din(BCD3), .Dout(Sout3));
Seven_Segment SS2(.Din(BCD2), .Dout(Sout2));
Seven_Segment SS1(.Din(BCD1), .Dout(Sout1));
Seven_Segment SS0(.Din(BCD0), .Dout(Sout0));

assign mode_out[2] = mode[1] & (!mode[0]);
assign mode_out[1] = (!mode[1]) & mode[0];
assign mode_out[0] = (!mode[1]) & (!mode[0]);

endmodule