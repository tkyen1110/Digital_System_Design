module Lab4_3(F, A);
input [0:3] A;
output [0:1] F;
reg [0:1] F;

always @ (A)
	if ((A==4'b0000)||(A==4'b0101))
		F[0:1] = 2'b00;
	else if ((A==4'b0001)||(A==4'b0110)||(A==4'b0111)||(A==4'b1000)
				||(A==4'b1001)||(A==4'b1101)||(A==4'b1110)||(A==4'b1111))
		F[0:1] = 2'b10;
	else if ((A==4'b0010)||(A==4'b0100))
		F <= 2'b01;
	else
		begin
		F[0]=1;
		F[1]=1;
		end

endmodule
