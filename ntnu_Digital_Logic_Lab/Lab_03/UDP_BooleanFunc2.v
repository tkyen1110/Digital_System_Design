primitive UDP_BooleanFunc2(F, A, B, C, D);
input A, B, C, D;
output F;

table
	0 0 0 0 : 0;
	0 0 0 1 : 0;
	0 0 1 0 : 1;
	0 0 1 1 : 1;
	0 1 0 0 : 1;
	0 1 0 1 : 0;
	0 1 1 0 : 0;
	0 1 1 1 : 0;
	1 0 0 0 : 0;
	1 0 0 1 : 0;
	1 0 1 0 : 1;
	1 0 1 1 : 1;
	1 1 0 0 : 1;
	1 1 0 1 : 0;
	1 1 1 0 : 0;
	1 1 1 1 : 0;
endtable

endprimitive