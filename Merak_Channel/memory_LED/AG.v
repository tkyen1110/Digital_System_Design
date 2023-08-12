module AG(clk, reset, addr);
input clk, reset;
output[3:0] addr;
reg[3:0] addr;

always@(posedge clk, negedge reset)
	if (!reset)
		addr <= 4'd0;
	else
		addr <= addr + 4'd1;

endmodule