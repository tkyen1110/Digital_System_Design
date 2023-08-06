module ripple_carry_4_bit_adder_subtracter_w_seven_segment(A, B, Cin, Sout, Cout, V);
input[3:0] A, B;
input Cin;
output[6:0] Sout;
output Cout;
output V; // overflow
wire[3:0] S;

ripple_carry_4_bit_adder_subtracter(.A(A), .B(B), .C0(Cin), .S(S), .C4(Cout), .V(V));
Seven_Segment(.Din(S), .Dout(Sout));

endmodule