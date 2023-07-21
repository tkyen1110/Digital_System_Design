module testbench_2_bit_demultiplexer;
reg[1:0] S;
reg D;
wire[3:0] Y;

demultiplexer_1to4 G0(S, D, Y);

initial
	begin
		S <= 2'b10;
		D <= 0;
	end

initial forever #30 D <= ~D;

initial
	#1000 $finish;

initial
	$monitor($time, " S=%b D=%b, Y=%b", S, D, Y);
endmodule