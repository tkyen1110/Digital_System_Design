module Carry_Lookahead_Adder_32_bit(A, B, Cin, S, Cout);
input[31:0] A, B;
input Cin;
output[31:0] S;
output Cout;
wire C4, C8, C12, C16, C20, C24, C28;

Carry_Lookahead_Adder_4_bit CLA4_0(.A(A[3:0])  , .B(B[3:0])  , .Cin(Cin) , .S(S[3:0])  , .Cout(C4));
Carry_Lookahead_Adder_4_bit CLA4_1(.A(A[7:4])  , .B(B[7:4])  , .Cin(C4)  , .S(S[7:4])  , .Cout(C8));
Carry_Lookahead_Adder_4_bit CLA4_2(.A(A[11:8]) , .B(B[11:8]) , .Cin(C8)  , .S(S[11:8]) , .Cout(C12));
Carry_Lookahead_Adder_4_bit CLA4_3(.A(A[15:12]), .B(B[15:12]), .Cin(C12) , .S(S[15:12]), .Cout(C16));
Carry_Lookahead_Adder_4_bit CLA4_4(.A(A[19:16]), .B(B[19:16]), .Cin(C16) , .S(S[19:16]), .Cout(C20));
Carry_Lookahead_Adder_4_bit CLA4_5(.A(A[23:20]), .B(B[23:20]), .Cin(C20) , .S(S[23:20]), .Cout(C24));
Carry_Lookahead_Adder_4_bit CLA4_6(.A(A[27:24]), .B(B[27:24]), .Cin(C24) , .S(S[27:24]), .Cout(C28));
Carry_Lookahead_Adder_4_bit CLA4_7(.A(A[31:28]), .B(B[31:27]), .Cin(C27) , .S(S[31:28]), .Cout(Cout));

endmodule