module testbench_2_bit_multiplexer;
reg[1:0] S;
reg[3:0] D;
wire Y;

multiplexer_4to1 G0(S, D, Y);

initial
	begin
		S <= 2'b00;
		D <= 4'b0000;
	end

initial forever #20 D[0] <= ~D[0];
initial forever #25 D[1] <= ~D[1];
initial forever #30 D[2] <= ~D[2];
initial forever #35 D[3] <= ~D[3];

initial
	#1000 $finish;

initial
	$monitor($time, " S=%b D=%b, Y=%b", S, D, Y);
endmodule