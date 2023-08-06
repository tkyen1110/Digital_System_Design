module ripple_carry_16_bit_adder_w_register(clk, reset, RW, data, addr, read_value, add_sout, add_cout);
input clk, reset, RW;
input[3:0] data;
input[2:0] addr;
output[3:0] read_value;
output[15:0] add_sout;
output add_cout;

wire[7:0] reg_en, decode_out;
wire[15:0] add_in_A, add_in_B;

reg[3:0] reg_file[7:0];

// decode the address
Decoder3to8 D0(.Din(addr), .Dout(decode_out));
assign reg_en = RW ? 8'd0 : decode_out;

// control the register file
always@(posedge clk, negedge reset)
	if(!reset)
		begin
			reg_file[0] <= 4'd0;
			reg_file[1] <= 4'd0;
			reg_file[2] <= 4'd0;
			reg_file[3] <= 4'd0;
			reg_file[4] <= 4'd0;
			reg_file[5] <= 4'd0;
			reg_file[6] <= 4'd0;
			reg_file[7] <= 4'd0;
		end
	else
		begin
			reg_file[0] <= reg_en[0] ? data : reg_file[0];
			reg_file[1] <= reg_en[1] ? data : reg_file[1];
			reg_file[2] <= reg_en[2] ? data : reg_file[2];
			reg_file[3] <= reg_en[3] ? data : reg_file[3];
			reg_file[4] <= reg_en[4] ? data : reg_file[4];
			reg_file[5] <= reg_en[5] ? data : reg_file[5];
			reg_file[6] <= reg_en[6] ? data : reg_file[6];
			reg_file[7] <= reg_en[7] ? data : reg_file[7];
		end

// send data to adder
assign read_value = reg_file[addr];
assign add_in_A = {reg_file[3], reg_file[2], reg_file[1], reg_file[0]};
assign add_in_B = {reg_file[7], reg_file[6], reg_file[5], reg_file[4]};
ripple_carry_16_bit_adder RCA(.A(add_in_A), .B(add_in_B), .S(add_sout), .Cout(add_cout));

endmodule