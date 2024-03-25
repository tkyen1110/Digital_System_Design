`ifndef ADDERS
`define ADDERS
`include "gates.v"
`timescale 1ns/1ps

// half adder, gate level modeling
module HA(output C, S, input A, B);
	XOR g0(S, A, B);
	AND g1(C, A, B);
endmodule

// full adder, gate level modeling
module FA(output CO, S, input A, B, CI);
	wire c0, s0, c1, s1;
	HA ha0(c0, s0, A, B);
	HA ha1(c1, s1, s0, CI);
	assign S = s1;
	OR or0(CO, c0, c1);
endmodule

// adder without delay, register-transfer level modeling
module adder_rtl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);
	assign {C3, S} = A+B+C0;
endmodule

//  ripple-carry adder, gate level modeling
//  Do not modify the input/output of module
module rca_gl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);

	// TODO:: Implement gate-level RCA
	wire C1, C2;
	FA FA0(.A(A[0]), .B(B[0]), .CI(C0), .S(S[0]), .CO(C1));
	FA FA1(.A(A[1]), .B(B[1]), .CI(C1), .S(S[1]), .CO(C2));
	FA FA2(.A(A[2]), .B(B[2]), .CI(C2), .S(S[2]), .CO(C3));
endmodule

// carry-lookahead adder, gate level modeling
// Do not modify the input/output of module
module cla_gl(
	output C3,       // carry output
	output[2:0] S,   // sum
	input[2:0] A, B, // operands
	input C0         // carry input
	);

	// TODO:: Implement gate-level CLA
	wire[2:0] P, G;
	HA HA0(.A(A[0]), .B(B[0]), .S(P[0]), .C(G[0]));
	HA HA1(.A(A[1]), .B(B[1]), .S(P[1]), .C(G[1]));
	HA HA2(.A(A[2]), .B(B[2]), .S(P[2]), .C(G[2]));

	wire C1, C2;
	assign C1=G[0]|(P[0]&C0);
	assign C2=G[1]|(P[1]&G[0])|(P[1]&P[0]&C0);
	assign C3=G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&C0);

	XOR XOR0(.A(P[0]), .B(C0), .Y(S[0]));
	XOR XOR1(.A(P[1]), .B(C1), .Y(S[1]));
	XOR XOR2(.A(P[2]), .B(C2), .Y(S[2]));
endmodule

`endif
