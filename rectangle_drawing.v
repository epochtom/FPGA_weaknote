`timescale 1ns / 1ps

module rectangle_drawing(
    input clk,
    input record_rect_pt,
    input draw_rectangle,
    input [9:0] cursor_x,
    input [9:0] cursor_y,
    input [9:0] x,
    input [9:0] y,
    output reg [9:0] recg_x_pt1,
    output reg [9:0] recg_y_pt1,
    output reg [9:0] recg_x_pt2,
    output reg [9:0] recg_y_pt2,
    output reg [1:0] state_rect
);
    reg state_switch;
    
    initial begin
        recg_x_pt1 = 0;
        recg_y_pt1 = 0;
        recg_x_pt2 = 0;
        recg_y_pt2 = 0;
        state_rect = 0;
    end
    
    always @(posedge clk) begin
        state_switch <= record_rect_pt;
    end

    always @(posedge state_switch) begin
        recg_x_pt1 <= cursor_x;
        recg_y_pt1 <= cursor_y; 
    end

    always @(negedge state_switch) begin
        recg_x_pt2 <= cursor_x;
        recg_y_pt2 <= cursor_y;  
    end

    always @(posedge clk) begin
        if (draw_rectangle)
            state_rect <= 2'b00;
        else if (state_rect == 2'b00)
            state_rect <= (x == recg_x_pt2 && y == recg_y_pt2) ? 2'b01 : 2'b00;
        else if (state_rect == 2'b01)
            state_rect <= (x == recg_x_pt2 && y == recg_y_pt2) ? 2'b10 : 2'b01;
    end
endmodule
