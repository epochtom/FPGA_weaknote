module ClockDivider(
    input clk_100MHz,
    output reg slow_clk1,
    output reg slow_clk2
);
    reg [18:0] slow_clk_counter1; // Counter for slower clock 1
    reg [20:0] slow_clk_counter2; // Counter for even slower clock 2
    
    initial begin
        slow_clk_counter1 = 0;
        slow_clk_counter2 = 0;
    end
    
    always @(posedge clk_100MHz) begin
        slow_clk_counter1 <= slow_clk_counter1 + 1;
        slow_clk_counter2 <= slow_clk_counter2 + 1;
    end

    always @(posedge clk_100MHz) begin
        slow_clk1 <= slow_clk_counter1[18]; // Adjust bit for different frequencies
        slow_clk2 <= slow_clk_counter2[20]; // Even slower clock
    end
endmodule