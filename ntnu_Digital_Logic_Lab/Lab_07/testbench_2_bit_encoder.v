module testbench_2_bit_encoder;
reg[4:0] D;
wire[1:0] Y;

encoder_4to2 DTB(D[3:0], Y);

initial
	begin
		for (D=5'b00000;D<=5'b01111;D=D+5'b00001)
			begin
				#100;
			end
	end

initial
	$monitor($time, " D=%b, Y=%b", D[3:0], Y);
endmodule