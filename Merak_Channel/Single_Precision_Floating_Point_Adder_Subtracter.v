module Single_Precision_Floating_Point_Adder_Subtracter(op, FA, FB, FS);
input op; // 0: Adder ; 1: Subtracter
input[31:0] FA, FB;
output[31:0] FS;

wire[31:0] FB_M;
wire FA_S, FB_S, FS_S;
wire[7:0] FA_E, FB_E, FS_E;
wire[7:0] Ex_diff;
wire[22:0] FA_F, FB_F, FS_F;
wire[25:0] FA_F_ext, FB_F_ext;
wire[25:0] FB_F_sh;
wire[25:0] FA_F_com, FB_F_com;
wire[25:0] FS_F_cal, FS_F_com;
wire[4:0] FS_shift_num;
wire valid, zero;

// merge the operation code and FB
assign FB_M = {op ^ FB[31], FB[30:0]};

// the inputs will be positive or negative
// switch the value of two input to make FA_E greater than FB_E
assign {FA_S, FA_E, FA_F} = (FA[30:23]>=FB[30:23]) ? FA : FB_M;
assign {FB_S, FB_E, FB_F} = (FA[30:23]<FB[30:23])  ? FA : FB_M;

// extend fraction with sign bit, carry bit and hidden bit
assign FA_F_ext = {3'b001, FA_F};
assign FB_F_ext = {3'b001, FB_F};

// use the exponent bits difference to align the fraction bits
assign Ex_diff = FA_E - FB_E;
assign FB_F_sh = FB_F_ext >> Ex_diff;

// if the number is negative, take the complement
assign FA_F_com = FA_S ? ~FA_F_ext + 26'd1 : FA_F_ext;
assign FB_F_com = FB_S ? ~FB_F_sh + 26'd1 : FB_F_sh;

// calculate the result
// if the result is negative, take the complement
assign FS_F_cal = FA_F_com + FB_F_com;
assign FS_F_com = FS_F_cal[25] ? ~FS_F_cal + 26'd1 : FS_F_cal;
// assign FS_F_com = FS_F_cal[25] ? ~(FS_F_cal - 26'd1) : FS_F_cal;

Priority_Encoder_32to5 PENC32(.Din({8'd0, FS_F_com[23:0]}), .Dout(FS_shift_num), .Valid(valid));

// normalized
assign FS_S = FS_F_cal[25];
assign FS_E = FS_F_com[24] ? FA_E+8'd1 : FA_E-(5'd23-FS_shift_num);
assign FS_F = FS_F_com[24] ? FS_F_com[23:1] : FS_F_com[22:0]<<(5'd23-FS_shift_num);

// zero detection
assign zero = !(valid | FS_F_com[24] | FS_F_com[25]); // why FS_F_com[25]?
assign FS = zero ? 32'd0 : {FS_S, FS_E, FS_F};

endmodule