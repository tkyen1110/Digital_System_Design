module dcache_sram
(
    clk_i,
    rst_i,
    addr_i,
    tag_i,
    data_i,
    enable_i,
    write_i,
    tag_o,
    data_o,
    hit_o
);

// I/O Interface from/to controller
input                   clk_i;
input                   rst_i;
input       [3:0]       addr_i;
input       [24:0]      tag_i;
input       [255:0]     data_i;
input                   enable_i;
input                   write_i;

output reg  [24:0]      tag_o;
output reg  [255:0]     data_o;
output                  hit_o;

// Memory
reg      [24:0]    tag [0:15][0:1];    
reg      [255:0]   data[0:15][0:1];
integer            i, j;

// 
wire     [1:0]     block_hit;
reg      [15:0]    lru;
assign block_hit[0] = (tag[addr_i][0][24] == 1) && (tag[addr_i][0][22:0] == tag_i[22:0]);
assign block_hit[1] = (tag[addr_i][1][24] == 1) && (tag[addr_i][1][22:0] == tag_i[22:0]);
assign hit_o = block_hit[0] || block_hit[1];


// Write Data      
// 1. Write hit
// 2. Read miss: Read from memory
always@(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        for (i=0;i<16;i=i+1) begin
            for (j=0;j<2;j=j+1) begin
                tag[i][j] <= 25'b0;
                data[i][j] <= 256'b0;
            end
        end
    end

    if (enable_i && write_i) begin
        // TODO: Handle your write of 2-way associative cache + LRU here
        case(block_hit)
            2'b01: begin    // cache write hit (block 0)
                tag[addr_i][0][23] <= 1'b1; // dirty bit
                data[addr_i][0] <= data_i;
                lru[addr_i] <= 1'b1;
            end
            2'b10: begin    // cache write hit (block 1)
                tag[addr_i][1][23] <= 1'b1; // dirty bit
                data[addr_i][1] <= data_i;
                lru[addr_i] <= 1'b0;
            end
            default: begin  // cache write miss, read from memory
                tag[addr_i][lru[addr_i]][24:23] <= 2'b10; // valid, but not dirty
                tag[addr_i][lru[addr_i]][22:0] <= tag_i[22:0];
                data[addr_i][lru[addr_i]] <= data_i;
            end
        endcase
    end

    //read hit
    if (enable_i && !write_i) begin
        case(block_hit)
            2'b01: begin
                lru[addr_i] <= 1'b1;
            end
            2'b10: begin
                lru[addr_i] <= 1'b0;
            end
        endcase
    end
end

// Read Data      
// TODO: tag_o=? data_o=? hit_o=?
always @(*)begin
    if (enable_i) begin
        case(block_hit)
            2'b01: begin
                tag_o <= tag[addr_i][0];
                data_o <= data[addr_i][0];
            end
            2'b10: begin
                tag_o <= tag[addr_i][1];
                data_o <= data[addr_i][1];
            end
            default: begin
                tag_o <= tag[addr_i][lru[addr_i]];
                data_o <= data[addr_i][lru[addr_i]];
            end
        endcase
    end
end

endmodule
