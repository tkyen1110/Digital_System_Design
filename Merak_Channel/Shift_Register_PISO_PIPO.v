module Shift_Register_PISO_PIPO(clk, reset, SW, PS, Sin, Pin, Sout, Pout);
input clk, reset, SW, PS, Sin;
input[7:0] Pin;
output Sout;
output[7:0] Pout;

reg[7:0] SReg;

// SW = 1 (Shift mode)
// SW = 0 (Write mode)
// PS = 1 (Parallel in)
// PS = 0 (Serial in)
always@(posedge clk, negedge reset)
	if (!reset)
		SReg <= 8'd0;
	else if (SW)
		SReg <= {SReg[6:0], SReg[7]};
	else
		SReg <= PS ? Pin : {SReg[6:0], Sin};

assign Sout = SReg[7];
assign Pout = SReg;
endmodule