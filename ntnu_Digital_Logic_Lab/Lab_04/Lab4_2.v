module Lab4_2(F, A);
input [0:3] A;
output [0:1] F;
reg [0:1] F;

always @ (A)
	case(A)
	4'b0000, 4'b0101:
		F[0:1]=2'b00;
	
	4'b0001, 4'b0110, 4'b0111, 4'b1000,
	4'b1001, 4'b1101, 4'b1110, 4'b1111:
		F[0:1]=2'b10;
	
	4'b0010, 4'b0100:
		F <= 2'b01;

	4'b0011, 4'b1010, 4'b1011, 4'b1100:
		begin
		F[0]=1;
		F[1]=1;
		end
	endcase
endmodule