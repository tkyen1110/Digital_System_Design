module Traffic_Light(clk, reset, LightA, LightB);
input clk, reset;
output[2:0] LightA, LightB;
reg[2:0] LightA, LightB;

reg[3:0] current_count, next_count;
reg[1:0] current_state, next_state;

// next state combinational logic
always@(current_count)
	case(current_state)
		2'b00:
			begin
				next_count <= (current_count<4'd8) ? current_count + 4'd1 : 4'd1;
				next_state <= (current_count<4'd8) ? 2'b00 : 2'b01;
			end
		2'b01:
			begin
				next_count <= (current_count<4'd3) ? current_count + 4'd1 : 4'd1;
				next_state <= (current_count<4'd3) ? 2'b01 : 2'b10;
			end
		2'b10:
			begin
				next_count <= (current_count<4'd10) ? current_count + 4'd1 : 4'd1;
				next_state <= (current_count<4'd10) ? 2'b10 : 2'b11;
			end
		2'b11:
			begin
				next_count <= (current_count<4'd3) ? current_count + 4'd1 : 4'd1;
				next_state <= (current_count<4'd3) ? 2'b11 : 2'b00;
			end
	endcase

// state register
always@(posedge clk, negedge reset)
	if (!reset)
		begin
			current_count <= 4'd1;
			current_state <= 2'b00;
		end
	else
		begin
			current_count <= next_count;
			current_state <= next_state;
		end

// output combinational logic
always@(current_state)
	case(current_state)
		2'b00:
			begin
				LightA <= 3'b001;
				LightB <= 3'b100;
			end
		2'b01:
			begin
				LightA <= 3'b010;
				LightB <= 3'b100;
			end
		2'b10:
			begin
				LightA <= 3'b100;
				LightB <= 3'b001;
			end
		2'b11:
			begin
				LightA <= 3'b100;
				LightB <= 3'b010;
			end
	endcase

endmodule