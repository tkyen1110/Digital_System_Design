module testbench_2_bit_decoder;
reg[2:0] D;
wire[3:0] Y;

decoder_2to4 DTB(D[1:0], Y);

initial
	begin
		for (D=3'b000;D<=3'b011;D=D+3'b001)
			begin
				#100;
			end
	end

initial
	$monitor($time, " D=%b, Y=%b", D[1:0], Y);
endmodule