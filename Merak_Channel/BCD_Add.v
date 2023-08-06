module BCD_Add(A, B, S, Cout);
input[7:0] A, B;
output[7:0] S;
output Cout;

wire[3:0] S0, S0_Add6, S1, S1_Add6;
wire CLA_Cout0, Add6_Cout0, CLA_Cin1, CLA_Cout1, Add6_Cout1;

Carry_Lookahead_Adder_4_bit CLA0(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .S(S0), .Cout(CLA_Cout0));
Add6 Add6_0(.Din(S0), .Dout(S0_Add6), .Cout(Add6_Cout0));
assign CLA_Cin1 = CLA_Cout0 | Add6_Cout0;
assign S[3:0] = CLA_Cin1 ? S0_Add6 : S0;

Carry_Lookahead_Adder_4_bit CLA1(.A(A[7:4]), .B(B[7:4]), .Cin(CLA_Cin1), .S(S1), .Cout(CLA_Cout1));
Add6 Add6_1(.Din(S1), .Dout(S1_Add6), .Cout(Add6_Cout1));
assign Cout = CLA_Cout1 | Add6_Cout1;
assign S[7:4] = Cout ? S1_Add6 : S1;

endmodule