module CursorSizeController(
    input clk,
    input sw_size,
    output reg [1:0] cursor_size
);
    reg sw_size_prev;           // Previous state of sw_size
    reg sw_size_latch;          // Latching register

    parameter SMALL = 2'b00, NORMAL = 2'b01, LARGE = 2'b10;

    initial begin
        cursor_size = NORMAL; // Initialize cursor size to normal
        sw_size_prev = 0;
        sw_size_latch = 0;
    end

    always @(posedge clk) begin
        sw_size_prev <= sw_size;
        if (sw_size && !sw_size_prev) begin // Detect rising edge
            sw_size_latch <= 1;
        end else begin
            sw_size_latch <= 0;
        end

        if (sw_size_latch) begin
            case (cursor_size)
                SMALL: cursor_size <= NORMAL;
                NORMAL: cursor_size <= LARGE;
                LARGE: cursor_size <= SMALL;
                default: cursor_size <= NORMAL;
            endcase
        end
    end
endmodule