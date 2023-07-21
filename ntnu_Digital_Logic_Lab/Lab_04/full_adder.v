module full_adder(output S, C, input x, y, k);
wire S1, C1, C2;

half_adder HA1(S1, C1, x, y);
half_adder HA2(S, C2, S1, k);
or G0(C, C2, C1);
endmodule