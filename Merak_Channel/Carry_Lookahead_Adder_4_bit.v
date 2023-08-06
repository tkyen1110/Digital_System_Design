module Carry_Lookahead_Adder_4_bit(A, B, Cin, S, Cout);
input[3:0] A, B;
input Cin;
output[3:0] S;
output Cout;

wire [3:0] P, G;
wire [3:1] C;

Half_Adder HA0(.A(A[0]), .B(B[0]), .S(P[0]), .Cout(G[0]));
Half_Adder HA1(.A(A[1]), .B(B[1]), .S(P[1]), .Cout(G[1]));
Half_Adder HA2(.A(A[2]), .B(B[2]), .S(P[2]), .Cout(G[2]));
Half_Adder HA3(.A(A[3]), .B(B[3]), .S(P[3]), .Cout(G[3]));

carry_lookahead_generator CLG0({Cout, C[3:1]}, P[3:0], G[3:0], Cin);

xor G0(S[0], P[0], Cin);
xor G1(S[1], P[1], C[1]);
xor G2(S[2], P[2], C[2]);
xor G3(S[3], P[3], C[3]);

endmodule