module Single_Precision_Floating_Point_Adder(FA, FB, FS);
input[31:0] FA, FB;
output[31:0] FS;

wire FA_S, FB_S, FS_S;
wire[7:0] FA_E, FB_E, FS_E;
wire[7:0] Ex_diff;
wire[22:0] FA_F, FB_F, FS_F;
wire[24:0] FA_F_ext, FB_F_ext;
wire[24:0] FB_F_sh, FS_F_cal;

// assuming that the inputs are positive
// switch the value of two input to make FA_E greater than FB_E
assign {FA_S, FA_E, FA_F} = (FA[30:23]>=FB[30:23]) ? FA : FB;
assign {FB_S, FB_E, FB_F} = (FA[30:23]<FB[30:23])  ? FA : FB;
assign FS = {FS_S, FS_E, FS_F};

// add the hidden bit
assign FA_F_ext = {2'b01, FA_F};
assign FB_F_ext = {2'b01, FB_F};

// use the exponent bits difference to align the fraction bits
assign Ex_diff = FA_E - FB_E;
assign FB_F_sh = FB_F_ext >> Ex_diff;

//calculate the result
assign FS_F_cal = FA_F_ext + FB_F_sh;

// normalized
assign FS_S = 1'b0;
assign FS_E = FS_F_cal[24] ? FA_E+8'd1 : FA_E;
assign FS_F = FS_F_cal[24] ? FS_F_cal[23:1]: FS_F_cal[22:0];
		
endmodule