module Queue_4bit_8(clk, reset, enable, push_pop, data_in, full, empty, data_out);
input clk, reset, enable, push_pop;
input[3:0] data_in;
output full, empty;
output[3:0] data_out;

reg[2:0] read_idx;
reg empty;
reg[3:0] queue_mem[7:0];

always@(posedge clk, negedge reset)
	if (!reset)
		begin
			read_idx <= 3'd0;
			empty <= 1'b1;
		end
	else
		if (enable)
			if (push_pop) // push
				begin
					if (!full)
						queue_mem[7] <= queue_mem[6];
						queue_mem[6] <= queue_mem[5];
						queue_mem[5] <= queue_mem[4];
						queue_mem[4] <= queue_mem[3];
						queue_mem[3] <= queue_mem[2];
						queue_mem[2] <= queue_mem[1];
						queue_mem[1] <= queue_mem[0];
						queue_mem[0] <= data_in;

					if (empty)
						begin
							empty <= 1'b0;
							read_idx <= 3'd0;
						end
					else
						read_idx <= full ? read_idx : read_idx + 3'd1;
					
				end
			else // pop
				begin
					read_idx <= (read_idx==3'd0 ? read_idx : read_idx - 3'd1);
					empty <= (read_idx==3'd0);
				end
				
assign full = (read_idx == 3'd7);
assign data_out = empty ? 4'd0 : queue_mem[read_idx];

endmodule
