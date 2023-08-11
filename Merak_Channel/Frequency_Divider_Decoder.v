module Frequency_Divider_Decoder(Din, Dout);
input[2:0] Din;
output[31:0] Dout;
reg[31:0] Dout;

always @(Din)
	case(Din)
		3'd0:
			Dout = 32'd200000000; // 1/4 Hz
		3'd1:
			Dout = 32'd150000000; // 1/3 Hz
		3'd2:
			Dout = 32'd100000000; // 1/2 Hz
		3'd3:
			Dout = 32'd50000000;  // 1 Hz
		3'd4:
			Dout = 32'd25000000;  // 2 Hz
		3'd5:
			Dout = 32'd16670000;  // 3 Hz
		3'd6:
			Dout = 32'd10000000;  // 5 Hz
		3'd7:
			Dout = 32'd8; // 32'd6250000; // 8 Hz
	endcase

endmodule