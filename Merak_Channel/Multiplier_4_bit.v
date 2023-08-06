module Multiplier_4_bit(A, B, P);
input [3:0] A, B;
output [7:0] P;

wire [3:0] MUout0, MUout1, MUout2, MUout3;
wire [3:0] CLA_S0, CLA_S1, CLA_S2, CLA_S3;
wire CLA_Cout0, CLA_Cout1, CLA_Cout2;

MultiplierUnit M0(.A(A), .Bi(B[0]), .MUout(MUout0));
MultiplierUnit M1(.A(A), .Bi(B[1]), .MUout(MUout1));
MultiplierUnit M2(.A(A), .Bi(B[2]), .MUout(MUout2));
MultiplierUnit M3(.A(A), .Bi(B[3]), .MUout(MUout3));

carry_lookahead_4_bit_adder_gatelevel CLA0(.A({1'b0, MUout0[3:1]}), .B(MUout1), .C0(1'b0), .S(CLA_S0), .C4(CLA_Cout0));
carry_lookahead_4_bit_adder_gatelevel CLA1(.A({CLA_Cout0, CLA_S0[3:1]}), .B(MUout2), .C0(1'b0), .S(CLA_S1), .C4(CLA_Cout1));
carry_lookahead_4_bit_adder_gatelevel CLA2(.A({CLA_Cout1, CLA_S1[3:1]}), .B(MUout3), .C0(1'b0), .S(CLA_S2), .C4(CLA_Cout2));

assign P[0] = MUout0[0];
assign P[1] = CLA_S0[0];
assign P[2] = CLA_S1[0];
assign P[6:3] = CLA_S2;
assign P[7] = CLA_Cout2;

endmodule