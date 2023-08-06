module MUX4to1(Din, sel, Dout);
input[3:0] Din;
input[1:0] sel;
output Dout;

wire M0_out, M1_out;

MUX2to1 M0(.a(Din[3]), .b(Din[2]), .sel(sel[0]), .c(M0_out));
MUX2to1 M1(.a(Din[1]), .b(Din[0]), .sel(sel[0]), .c(M1_out));
MUX2to1 M2(.a(M0_out), .b(M1_out), .sel(sel[1]), .c(Dout));

endmodule