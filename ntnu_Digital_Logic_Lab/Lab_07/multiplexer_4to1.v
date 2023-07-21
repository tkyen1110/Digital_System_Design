module multiplexer_4to1(S, D, Y);
input[1:0] S;
input[3:0] D;
output Y;
reg Y;

always @ (S or D)
	case(S)
	2'b00: Y=D[0];
	2'b01: Y=D[1];
	2'b10: Y=D[2];
	2'b11: Y=D[3];
	endcase
endmodule