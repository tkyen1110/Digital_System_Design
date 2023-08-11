module Mode_Control(trigger, reset, mode);
input trigger, reset;
output[1:0] mode;
reg[1:0] mode, next_mode;

always@(posedge trigger, negedge reset)
	if(!reset)
		mode <= 2'd0;
	else
		mode <= next_mode;

always@(mode)
	case(mode)
		2'd0:
			next_mode = 2'd1;
		2'd1:
			next_mode = 2'd2;
		2'd2:
			next_mode = 2'd0;
		default:
			next_mode = 2'd0;
	endcase

endmodule