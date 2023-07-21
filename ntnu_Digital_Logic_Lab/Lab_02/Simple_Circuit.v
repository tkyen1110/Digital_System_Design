module Simple_Circuit(I1, I2, Onot, Oand, Oor);
input I1, I2;
output Onot, Oand, Oor;

not G1(Onot, I1);
and G2(Oand, I1, I2);
or G3(Oor, I1, I2);
endmodule