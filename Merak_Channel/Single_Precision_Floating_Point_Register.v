module Single_Precision_Floating_Point_Register(clk, reset, Din, FP_1, FP_2);
input clk, reset;
input[7:0] Din;
output[31:0] FP_1, FP_2;
reg[31:0] FP_1, FP_2;

always@(posedge clk, negedge reset)
	if(!reset)
		begin
			FP_1 <= 32'd0;
			FP_2 <= 32'd0;
		end
	else
		begin
			FP_2[7:0]   <= Din;
			FP_2[15:8]  <= FP_2[7:0];
			FP_2[23:16] <= FP_2[15:8];
			FP_2[31:24] <= FP_2[23:16];
			FP_1[7:0]   <= FP_2[31:24];
			FP_1[15:8]  <= FP_1[7:0];
			FP_1[23:16] <= FP_1[15:8];
			FP_1[31:24] <= FP_1[23:16];
		end
		
endmodule