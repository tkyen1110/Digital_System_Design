module ripple_carry_4_bit_adder(output [3:0] S, output C4, input [3:0] A, B, input C0);
wire [3:1] C;

full_adder FA0(S[0], C[1], A[0], B[0],  C0 );
full_adder FA1(S[1], C[2], A[1], B[1], C[1]);
full_adder FA2(S[2], C[3], A[2], B[2], C[2]);
full_adder FA3(S[3],  C4 , A[3], B[3], C[3]);
endmodule