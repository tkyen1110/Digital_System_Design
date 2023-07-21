module Lab2_4(A, B, C, D, F1, F2);
input A, B, C, D;
output F1, F2;

assign F1 = A || (B&&C) || (!B&&D);
assign F2 = (!B&&C) || (B&&!C&&!D);
endmodule
