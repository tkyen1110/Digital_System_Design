module half_adder_2(S, C, x, y);
input x, y;
output S, C;

xor G0(S, x, y);
and G1(C, x, y);
endmodule