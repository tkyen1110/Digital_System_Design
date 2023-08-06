module ripple_carry_4_bit_adder_w_seven_segment(A, B, Cin, Sout, Cout);
input[3:0] A, B;
input Cin;
output[6:0] Sout;
output Cout;

wire[3:0] S;

ripple_carry_4_bit_adder RCA4(.A(A), .B(B), .C0(Cin), .S(S), .C4(Cout));
Seven_Segment S0(.Din(S), .Dout(Sout));

endmodule