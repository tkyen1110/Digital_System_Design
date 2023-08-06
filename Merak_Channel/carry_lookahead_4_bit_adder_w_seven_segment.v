module carry_lookahead_4_bit_adder_w_seven_segment(A, B, Cin, Sout, Cout);
input[3:0] A, B;
input Cin;
output[6:0] Sout;
output Cout;

wire[3:0] S;

carry_lookahead_4_bit_adder_gatelevel CLA4(.A(A), .B(B), .C0(Cin), .S(S), .C4(Cout));
Seven_Segment(.Din(S), .Dout(Sout));

endmodule