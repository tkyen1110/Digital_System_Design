module Lab3_1(F, A);
input[0:3] A;
output[0:1] F;
wire[0:6] w;

not G0(w[0], A[1]);
not G1(w[1], A[2]);
not G2(w[2], A[3]);
and G3(w[3], w[0], A[3]);
and G4(w[4], A[1], A[2]);
and G5(w[5], w[0], A[2]);
and G6(w[6], A[1], w[1], w[2]);
or G7(F[0], A[0], w[3], w[4]);
or G8(F[1], w[5], w[6]);
endmodule