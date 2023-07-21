module Simple_Circuit2(I1, I2, Onot, Oand, Oor);
input I1, I2;
output Onot, Oand, Oor;
wire w;

not G0(w, I1);
not G1(Onot, w);
and G2(Oand, I1, I2);
or G3(Oor, I1, I2);
endmodule
