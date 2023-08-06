module ripple_carry_4_bit_adder_subtracter(output [3:0] S, output C4, output V, input [3:0] A, B, input C0);
wire [3:1] C;
wire [3:0] NB;

// assign NB=((~B)&{4{C0}}) | (B&{4{!C0}});
assign NB= B^{4{C0}};

Full_Adder FA0(.A(A[0]), .B(NB[0]), .Cin(C0)  , .S(S[0]), .Cout(C[1]));
Full_Adder FA1(.A(A[1]), .B(NB[1]), .Cin(C[1]), .S(S[1]), .Cout(C[2]));
Full_Adder FA2(.A(A[2]), .B(NB[2]), .Cin(C[2]), .S(S[2]), .Cout(C[3]));
Full_Adder FA3(.A(A[3]), .B(NB[3]), .Cin(C[3]), .S(S[3]), .Cout(C4)  );

assign V = C[3]^C4; // overflow

endmodule