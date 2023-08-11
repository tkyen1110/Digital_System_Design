module Stack_4bit_8_display(clk, btn, reset, enable, push_pop, data_in, full, empty, Sout);
input clk, btn, reset, enable, push_pop;
input[3:0] data_in;
output full, empty;
output[6:0] Sout;

wire DC_Dout;
wire[3:0] data_out;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(DC_Dout));
Stack_4bit_8 Stack(.clk(DC_Dout), .reset(reset), .enable(enable), .push_pop(push_pop), .data_in(data_in), .full(full), .empty(empty), .data_out(data_out));
Seven_Segment SS(.Din(data_out), .Dout(Sout));

endmodule