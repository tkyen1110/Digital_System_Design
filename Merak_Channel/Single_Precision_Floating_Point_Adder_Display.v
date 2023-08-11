module Single_Precision_Floating_Point_Adder_Display(clk, btn, reset, HL, Din, Sout3, Sout2, Sout1, Sout0);
input clk, btn, reset, HL;
input[7:0] Din;
output[6:0] Sout3, Sout2, Sout1, Sout0;

wire DC_out;
wire[31:0] FA, FB;
wire[15:0] FS_Hi, FS_Lo, FS_Dis;

Debounce_Circuit DC(.clk(clk), .reset(reset), .Din(btn), .Dout(DC_out));
Single_Precision_Floating_Point_Register FPR(.clk(DC_out), .reset(reset), .Din(Din), .FP_1(FA), .FP_2(FB));
Single_Precision_Floating_Point_Adder FPA(.FA(FA), .FB(FB), .FS({FS_Hi, FS_Lo}));
assign FS_Dis = HL ? FS_Hi : FS_Lo;

Seven_Segment SS3(.Din(FS_Dis[15:12]), .Dout(Sout3));
Seven_Segment SS2(.Din(FS_Dis[11:8]), .Dout(Sout2));
Seven_Segment SS1(.Din(FS_Dis[7:4]), .Dout(Sout1));
Seven_Segment SS0(.Din(FS_Dis[3:0]), .Dout(Sout0));

endmodule