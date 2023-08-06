module MUX8to1(Din, sel, Dout);
input[7:0] Din;
input[2:0] sel;
output Dout;

wire M0_out, M1_out;

MUX4to1 M0(.Din(Din[7:4]), .sel(sel[1:0]), .Dout(M0_out));
MUX4to1 M1(.Din(Din[3:0]), .sel(sel[1:0]), .Dout(M1_out));
MUX2to1 M2(.a(M0_out), .b(M1_out), .sel(sel[2]), .c(Dout));

endmodule