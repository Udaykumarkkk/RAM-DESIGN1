

module ram(
    input clk,
    input write_en,
    input read_en,
    input [7:0] addr,
    input [31:0] data_in,
    output [31:0] data_out
);

reg [31:0] mem [0:255];

always @(posedge clk) begin
    if (write_en) begin
        mem[addr] <= data_in;
    end
end

assign data_out = (read_en) ? mem[addr] : 32'd0;

endmodule







Testbench Code

module ram_tb;

reg clk;
reg write_en;
reg read_en;
reg [7:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

ram u_ram(
    .clk(clk),
    .write_en(write_en),
    .read_en(read_en),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    write_en = 0;
    read_en = 0;
    addr = 0;
    data_in = 0;
end

always #5 clk = ~clk;

initial begin
    // Write data to RAM
    #10 write_en = 1;
    addr = 8'd0;
    data_in = 32'h12345678;
    #10 write_en = 0;

    // Read data from RAM
    #10 read_en = 1;
    addr = 8'd0;
    #10 read_en = 0;

    // Verify data
    #10 if (data_out !== 32'h12345678) begin
        $display("Error: Data out does not match expected value");
    end

    #100 $finish;
end

endmodule
