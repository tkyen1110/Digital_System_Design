module Electronic_Clock(clk, reset, mode, wen, wdata, display_num);
input clk, reset, wen;
input[1:0] mode;
input[7:0] wdata;
output[15:0] display_num;

reg[7:0] hour, minute, second;
reg[15:0] display_num;
wire[7:0] hour_add, minute_add, second_add;
wire[7:0] next_hour, next_minute, next_second;

// next time generator
Carry_Lookahead_Adder_8_bit CLA0(.A(second), .B(8'd1), .Cin(8'd0), .S(second_add), .Cout());
Carry_Lookahead_Adder_8_bit CLA1(.A(minute), .B(8'd1), .Cin(8'd0), .S(minute_add), .Cout());
Carry_Lookahead_Adder_8_bit CLA2(.A(hour)  , .B(8'd1), .Cin(8'd0), .S(hour_add)  , .Cout());
assign next_second = (second_add==8'd60) ? 8'd0 : second_add;
assign next_minute = (second_add==8'd60) ? ((minute_add==8'd60) ? 8'd0 : minute_add) : minute;
assign next_hour   = (minute_add==8'd60) ? ((hour_add==8'd24) ? 8'd0 : hour_add) : hour;

// time register
always@(posedge clk, negedge reset)
	if(!reset)
		begin
			hour <= 8'd0;
			minute <= 8'd0;
			second <= 8'd0;
		end
	else
		begin
			hour   <= (wen & (mode==2'd2)) ? ((wdata>=8'd24) ? 8'd0 : wdata) : next_hour;
			minute <= (wen & (mode==2'd1)) ? ((wdata>=8'd60) ? 8'd0 : wdata) : next_minute;
			second <= (wen & (mode==2'd0)) ? ((wdata>=8'd60) ? 8'd0 : wdata) : next_second;
		end

// display number
always@(mode)
	case(mode)
		2'b00, 2'd10:
			display_num = {minute, second};
		2'd01, 2'b11:
			display_num = {hour, minute};
	endcase

endmodule