module mem_LED(clk, reset, Fsel, Psel, LEDout);
input clk, reset, Psel;
input[2:0] Fsel;
output[7:0] LEDout;

wire mem_clk;
wire[3:0] AG_addr;
wire[4:0] mem_addr;
assign mem_addr = {Psel, AG_addr};

Frequency_Divider FDiv(.Fin(clk), .Fsel(Fsel), .Fout(mem_clk));
AG AG0(.clk(mem_clk), .reset(reset), .addr(AG_addr));
mem1 m0(.address(mem_addr), .clock(mem_clk), .data(8'd0), .wren(1'b0), .q(LEDout));

endmodule