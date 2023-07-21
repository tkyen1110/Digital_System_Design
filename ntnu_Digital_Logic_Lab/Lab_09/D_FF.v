module D_FF(output reg Q, input D, Clk, rst);
always @(posedge Clk, negedge rst)
	if (!rst)
		Q <= 1'b0;
	else
		Q <= D;
endmodule