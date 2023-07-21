module D_latch(output reg Q, input enable, D);
always @(enable, D)
	if (enable)
		Q <= D;
endmodule