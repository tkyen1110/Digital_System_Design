module Full_Adder(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
wire S1, C1, C2;

Half_Adder HA1(.A(A), .B(B), .S(S1), .Cout(C1));
Half_Adder HA2(.A(S1), .B(Cin), .S(S), .Cout(C2));
or G0(Cout, C2, C1);

endmodule