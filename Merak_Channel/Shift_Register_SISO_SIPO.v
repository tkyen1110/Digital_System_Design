module Shift_Register_SISO_SIPO(clk, reset, SW, Din, Sout, Pout);
input clk, reset, SW, Din;
output Sout;
output[7:0] Pout;

reg[7:0] SReg;
wire Sin;

// SW = 1 (Shift mode)
// SW = 0 (Write mode)
assign Sin = SW ? SReg[7] : Din;
always@(posedge clk, negedge reset)
	if (!reset)
		SReg <= 8'd0;
	else
		SReg <= {SReg[6:0], Sin};

assign Sout = SReg[7];
assign Pout = SReg;
endmodule