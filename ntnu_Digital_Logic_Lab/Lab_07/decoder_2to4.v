module decoder_2to4(D, Y);
input[1:0] D;
output[3:0] Y;
reg[3:0] Y;

always @ (D)
	case(D)
	2'b00: Y=4'b0001;
	2'b01: Y=4'b0010;
	2'b10: Y=4'b0100;
	2'b11: Y=4'b1000;
	endcase
endmodule