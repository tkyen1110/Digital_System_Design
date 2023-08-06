module Seven_Segment(Din, Dout);
input[3:0] Din;
output[6:0] Dout;
reg[6:0] Dout;

always @(Din)
	case(Din)
							  //gfedcba
		4'b0000: Dout = 7'b1000000; // "0"  
		4'b0001: Dout = 7'b1111001; // "1" 
		4'b0010: Dout = 7'b0100100; // "2" 
		4'b0011: Dout = 7'b0110000; // "3" 
		4'b0100: Dout = 7'b0011001; // "4" 
		4'b0101: Dout = 7'b0010010; // "5" 
		4'b0110: Dout = 7'b0000010; // "6" 
		4'b0111: Dout = 7'b1111000; // "7" 
		4'b1000: Dout = 7'b0000000; // "8"  
		4'b1001: Dout = 7'b0010000; // "9" 
		4'b1010: Dout = 7'b0001000; // "A" 
		4'b1011: Dout = 7'b0000011; // "B" 
		4'b1100: Dout = 7'b1000110; // "C" 
		4'b1101: Dout = 7'b0100001; // "D" 
		4'b1110: Dout = 7'b0000110; // "E" 
		4'b1111: Dout = 7'b0001110; // "F"	
	endcase
endmodule