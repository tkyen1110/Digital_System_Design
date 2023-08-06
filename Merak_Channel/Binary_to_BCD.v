module Binary_to_BCD(Binary, BCD_2, BCD_1, BCD_0);
input[7:0] Binary;
output[3:0] BCD_2, BCD_1, BCD_0;

wire[3:0] Add6_Out0;
wire Add6_Cout0, BADD_Cout0, BADD_Cout1, BADD_Cout2, BADD_Cout3;
wire[7:0] BCD_Sum8, BCD_Sum16, BCD_Sum32, BCD_Sum64, BCD_Sum128;
wire[7:0] BADD_B0, BADD_B1, BADD_B2, BADD_B3;

Add6 Add6_0(.Din(Binary[3:0]), .Dout(Add6_Out0), .Cout(Add6_Cout0));
assign BCD_Sum8[3:0] = Add6_Cout0 ? Add6_Out0 : Binary[3:0];
assign BCD_Sum8[7:4] = {3'b000, Add6_Cout0};

assign BADD_B0 = Binary[4] ? 8'h16 : 8'h00;
BCD_Add BADD0(.A(BCD_Sum8) , .B(BADD_B0), .S(BCD_Sum16) , .Cout(BADD_Cout0));

assign BADD_B1 = Binary[5] ? 8'h32 : 8'h00;
BCD_Add BADD1(.A(BCD_Sum16), .B(BADD_B1), .S(BCD_Sum32) , .Cout(BADD_Cout1));

assign BADD_B2 = Binary[6] ? 8'h64 : 8'h00;
BCD_Add BADD2(.A(BCD_Sum32), .B(BADD_B2), .S(BCD_Sum64) , .Cout(BADD_Cout2));

assign BADD_B3 = Binary[7] ? 8'h28 : 8'h00;
BCD_Add BADD3(.A(BCD_Sum64), .B(BADD_B3), .S(BCD_Sum128), .Cout(BADD_Cout3));

assign BCD_1 = BCD_Sum128[7:4];
assign BCD_0 = BCD_Sum128[3:0];

Full_Adder FA(.A(Binary[7]), .B(BADD_Cout2 | BADD_Cout3), .Cin(1'b0), .S(BCD_2[0]), .Cout(BCD_2[1]));
assign BCD_2[3:2] = 2'b00;

endmodule