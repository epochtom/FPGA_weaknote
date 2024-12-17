module CursorPositionController(
    input clk,
    input [1:0] cursor_size,
    input sw_up,
    input sw_down,
    input sw_left,
    input sw_right,
    output reg [9:0] cursor_x,
    output reg [9:0] cursor_y
);
    initial begin
        cursor_x = 320; // Initial cursor position at the center of the screen
        cursor_y = 240; // Initial cursor position at the center of the screen
    end

    always @(posedge clk) begin
        case (cursor_size)
            2'b00: begin
                if (sw_up && !sw_down && cursor_y > 0) begin
                    cursor_y <= cursor_y - 1;
                end else if (sw_down && !sw_up && cursor_y < 476) begin
                    cursor_y <= cursor_y + 1;
                end
                if (sw_left && !sw_right && cursor_x > 0) begin
                    cursor_x <= cursor_x - 1;
                end else if (sw_right && !sw_left && cursor_x < 635) begin
                    cursor_x <= cursor_x + 1;
                end
            end
            2'b01: begin
                if (sw_up && !sw_down && cursor_y > 0) begin
                    cursor_y <= cursor_y - 1;
                end else if (sw_down && !sw_up && cursor_y < 472) begin
                    cursor_y <= cursor_y + 1;
                end
                if (sw_left && !sw_right && cursor_x > 0) begin
                    cursor_x <= cursor_x - 1;
                end else if (sw_right && !sw_left && cursor_x < 631) begin
                    cursor_x <= cursor_x + 1;
                end
            end
            2'b10: begin
                if (sw_up && !sw_down && cursor_y > 0) begin
                    cursor_y <= cursor_y - 1;
                end else if (sw_down && !sw_up && cursor_y < 460) begin
                    cursor_y <= cursor_y + 1;
                end
                if (sw_left && !sw_right && cursor_x > 0) begin
                    cursor_x <= cursor_x - 1;
                end else if (sw_right && !sw_left && cursor_x < 619) begin
                    cursor_x <= cursor_x + 1;
                end
            end
        endcase
    end
endmodule