module Debounce_Circuit(clk, reset, Din, Dout);
input clk, reset, Din;
output Dout;
reg Dout;

reg[2:0] current_state, next_state;

// next state combinational logic
always@(*)
	case(current_state)
		3'd0:
			next_state <= (Din==1'b0) ? 3'd1 : 3'd0;
		3'd1:
			next_state <= (Din==1'b0) ? 3'd2 : 3'd0;
		3'd2:
			next_state <= (Din==1'b0) ? 3'd3 : 3'd0;
		3'd3:
			next_state <= (Din==1'b0) ? 3'd4 : 3'd0;
		3'd4:
			next_state <= (Din==1'b0) ? 3'd5 : 3'd0;
		3'd5:
			next_state <= (Din==1'b0) ? 3'd5 : 3'd0;
		default:
			next_state <= (Din==1'b0) ? 3'd1 : 3'd0;
	endcase

// state register
always@(posedge clk, negedge reset)
	if (!reset)
		current_state <= 3'd0;
	else
		current_state <= next_state;

// output combinational logic
always@(current_state)
	case(current_state)
		3'd0:
			Dout <= 1'b1;
		3'd1:
			Dout <= 1'b1;
		3'd2:
			Dout <= 1'b1;
		3'd3:
			Dout <= 1'b1;
		3'd4:
			Dout <= 1'b1;
		3'd5:
			Dout <= 1'b0;
		default:
			Dout <= 1'b1;
	endcase

endmodule