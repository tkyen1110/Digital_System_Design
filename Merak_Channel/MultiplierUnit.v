module MultiplierUnit(A, Bi, MUout);
input [3:0] A;
input Bi;
output [3:0] MUout;

assign MUout= A & {4{Bi}};

endmodule