`timescale 1ns / 1ps

module Layer_BRAM (
    input clk,
    input [18:0] addr,  // Larger address bus to accommodate more pixels
    input [2:0] data_in,
    input we,
    output reg [2:0] data_out
);
    // Memory array for 320x240 pixels
    reg [2:0] ram [0:76799];  // Increased size to handle 307,200 addresses
    integer i;  // Declare the integer outside the initial block

    initial begin
        for (i = 0; i < 38400; i = i + 1) begin
            ram[i] <= 3'b111;  // Initialize all to white color
            ram[38400 + i] <= 3'b111;  // Initialize all to white color
        end
    end

    always @(posedge clk) begin
        if (we)
            ram[addr] <= data_in;  // Write
        data_out <= ram[addr];     // Read
    end
endmodule