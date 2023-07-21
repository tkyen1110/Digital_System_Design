module Simple_Circuit_Boolean(I1, I2, Onot, Oand, Oor);
input I1, I2;
output Onot, Oand, Oor;

assign Onot = !I1;
assign Oand = I1&&I2;
assign Oor = I1||I2;
endmodule
