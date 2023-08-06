module Traffic_Light_w_Frequency_Divider(clk, reset, LightA, LightB);
input clk, reset;
output[2:0] LightA, LightB;
wire clk_ls;

Frequency_Divider FDiv(.Fin(clk), .Fsel(3'd3), .Fout(clk_ls));
Traffic_Light TL(.clk(clk_ls), .reset(reset), .LightA(LightA), .LightB(LightB));

endmodule