module half_adder(output S, C, input x, y);

xor(S, x, y);
and(C, x, y);

endmodule