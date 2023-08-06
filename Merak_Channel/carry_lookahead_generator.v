module carry_lookahead_generator(output [4:1] C, input [3:0] P, G, input C0);

assign C[1]=G[0]|(P[0]&C0);
assign C[2]=G[1]|(P[1]&G[0])|(P[1]&P[0]&C0);
assign C[3]=G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&C0);
assign C[4]=G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&C0);
endmodule