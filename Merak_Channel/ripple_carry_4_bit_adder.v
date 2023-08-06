module ripple_carry_4_bit_adder(output [3:0] S, output C4, input [3:0] A, B, input C0);
wire [3:1] C;

Full_Adder FA0(.A(A[0]), .B(B[0]), .Cin(C0)  , .S(S[0]), .Cout(C[1]));
Full_Adder FA1(.A(A[1]), .B(B[1]), .Cin(C[1]), .S(S[1]), .Cout(C[2]));
Full_Adder FA2(.A(A[2]), .B(B[2]), .Cin(C[2]), .S(S[2]), .Cout(C[3]));
Full_Adder FA3(.A(A[3]), .B(B[3]), .Cin(C[3]), .S(S[3]), .Cout(C4)  );

endmodule