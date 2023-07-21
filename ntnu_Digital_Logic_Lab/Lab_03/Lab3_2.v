module Lab3_2(F, A);
input[0:3] A;
output[0:1] F;

UDP_BooleanFunc1 G0(F[0], A[0], A[1], A[2], A[3]);
UDP_BooleanFunc2 G1(F[1], A[0], A[1], A[2], A[3]);
endmodule