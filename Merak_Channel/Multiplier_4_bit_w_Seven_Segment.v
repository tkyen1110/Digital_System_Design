module Multiplier_4_bit_w_Seven_Segment(A, B, Sout0, Sout1);
input [3:0] A, B;
output [6:0] Sout0, Sout1;
wire [7:0] P;

Multiplier_4_bit M0(.A(A), .B(B), .P(P));
Seven_Segment S0(.Din(P[3:0]), .Dout(Sout0));
Seven_Segment S1(.Din(P[7:4]), .Dout(Sout1));

endmodule