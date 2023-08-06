module ripple_carry_16_bit_adder(A, B, S, Cout);
input[15:0] A, B;
output[15:0] S;
output Cout;
 
wire C4, C8, C12;

ripple_carry_4_bit_adder RCA0 (.A(A[3:0])  , .B(B[3:0])  , .C0(1'b0), .S(S[3:0])  , .C4(C4));
ripple_carry_4_bit_adder RCA1 (.A(A[7:4])  , .B(B[7:4])  , .C0(C4)  , .S(S[7:4])  , .C4(C8));
ripple_carry_4_bit_adder RCA2 (.A(A[11:8]) , .B(B[11:8]) , .C0(C8)  , .S(S[11:8]) , .C4(C12));
ripple_carry_4_bit_adder RCA3 (.A(A[15:12]), .B(B[15:12]), .C0(C12) , .S(S[15:12]), .C4(Cout));

endmodule