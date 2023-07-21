`timescale 1ns/10ps
module Lab4_4;
reg [3:0] in;
wire [0:1] out;
// Model to be tested
Lab2_3 G0(out[0], out[1], in[3], in[2], in[1], in[0]);

initial
	begin
	in <= 4'b0000;
	#40 in <= 4'b0001;
	#40 in <= 4'b0010;
	#40 in <= 4'b0011;
	#40 in <= 4'b0100;
	#40 in <= 4'b0101;
	#40 in <= 4'b0110;
	#40 in <= 4'b0111;
	#40 in <= 4'b1000;
	#40 in <= 4'b1001;
	#40 in <= 4'b1010;
	#40 in <= 4'b1011;
	#40 in <= 4'b1100;
	#40 in <= 4'b1101;
	#40 in <= 4'b1110;
	#40 in <= 4'b1111;
	#40 $finish;
	end

initial
	$monitor($time, "\t Output F1=%d F2=%d", out[0], out[1]);

endmodule
