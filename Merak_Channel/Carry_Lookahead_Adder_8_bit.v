module Carry_Lookahead_Adder_8_bit(A, B, Cin, S, Cout);
input[7:0] A, B;
input Cin;
output[7:0] S;
output Cout;
wire C4;

Carry_Lookahead_Adder_4_bit CLA4_0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C4));
Carry_Lookahead_Adder_4_bit CLA4_1(.A(A[7:4]), .B(B[7:4]), .Cin(C4) , .S(S[7:4]), .Cout(Cout));

endmodule