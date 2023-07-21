module Lab2_3(F1, F2, A, B, C, D);
input A, B, C ,D;
output F1, F2;
wire w1, w2, w3, w4, w5, w6, w7;

not G0(w1, B);
not G1(w2, C);
not G2(w3, D);
and G3(w4, w1, D);
and G4(w5, B, C);
and G5(w6, w1, C);
and G6(w7, B, w2, w3);
or G7(F1, A, w4, w5);
or G8(F2, w6, w7);
endmodule
