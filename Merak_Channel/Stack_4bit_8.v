module Stack_4bit_8(clk, reset, enable, push_pop, data_in, full, empty, data_out);
input clk, reset, enable, push_pop;
input[3:0] data_in;
output full, empty;
output[3:0] data_out;

wire[2:0] write_sp;
reg empty;
reg[2:0] sp; // stack pointer
reg[3:0] stack_mem[0:7];

always@(posedge clk, negedge reset)
	if (!reset)
		begin
			sp <= 3'd0;
			empty <= 1'b1;
		end
	else
		if (enable)
			if (push_pop) // push
				begin
					stack_mem[write_sp] <= full ? stack_mem[write_sp] : data_in;
					sp <= write_sp;
					empty <= 1'b0;
				end
			else  // pop
				begin
					sp <= (sp==3'd0) ? 3'd0 : sp - 3'd1;
					empty <= (sp==3'd0);
				end

assign write_sp = full ? sp : (empty ? 3'd0 : sp + 3'd1);
assign full = (sp == 3'd7);
assign data_out = empty ? 4'd0 : stack_mem[sp];

endmodule