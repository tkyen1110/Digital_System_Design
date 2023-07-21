module test_binary_adder;
reg [4:0] A, B;
reg [1:0] K;
wire [3:0] S;
wire C;

// Model to be tested
// ripple_carry_4_bit_adder RC1(S, C, A[3:0], B[3:0], K[0]);
carry_lookahead_4_bit_adder_gatelevel CLA1(S, C, A[3:0], B[3:0], K[0]);

initial
	begin
		for (A=5'b00000; A<=5'b01111; A=A+5'b00001)
			for (B=5'b00000; B<=5'b01111; B=B+5'b00001)
				for (K=5'b00; K<=5'b01; K=K+2'b01)
					#40;
	end

initial
	$monitor($time, "\t A=%d B=%d K=%d S=%d C=%d", A, B, K, S, C);
endmodule