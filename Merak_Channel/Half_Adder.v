module Half_Adder(A, B, S, Cout);
input A, B;
output S, Cout;

xor(S, A, B);
and(Cout, A, B);

endmodule