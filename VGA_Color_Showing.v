// VGA_Color_Showing module
module VGA_Color_Showing(
    input video_on,
    input [9:0] x, y,
    input [2:0] stored_rgb_reg,
    input [1:0] cursor_size,
    input [9:0] cursor_x, cursor_y,
    input [9:0] recg_x_pt1, recg_y_pt1, recg_x_pt2, recg_y_pt2,
    input [1:0] state_rect,
    input show_layer_1, show_layer_2, show_layer_3,
    input [2:0] layer1_color,
    input [2:0] layer2_color,
    input [2:0] layer3_color,
    output reg [2:0] rgb_temp // Change to reg type
);

    // Combinational always block for next state logic
    always @(*) begin
        if (video_on == 1'b0)
            rgb_temp <= 3'b000;
        else if ((x >= (cursor_x + 1) && x < (cursor_x + 1) + (cursor_size == 2'b10 ? 20 : (cursor_size == 2'b00 ? 4 : 8)) 
                     && y >= cursor_y && y < cursor_y + (cursor_size == 2'b10 ? 20 : (cursor_size == 2'b00 ? 4 : 8)))) begin
            rgb_temp <= ((x == (cursor_x + 1) || x == (cursor_x + 1) + (cursor_size == 2'b10 ? 19 : (cursor_size == 2'b00 ? 3 : 7)) 
                || y == cursor_y || y == cursor_y + (cursor_size == 2'b10 ? 19 : (cursor_size == 2'b00 ? 3 : 7)))
                ? 3'b000 : stored_rgb_reg);
        end
        // Draw rectangle
        else if ((((x >= recg_x_pt1) && (x <= recg_x_pt2)) || ((x <= recg_x_pt1) && (x >= recg_x_pt2))) && 
                  (((y >= recg_y_pt1) && (y <= recg_y_pt2)) || ((y <= recg_y_pt1) && (y >= recg_y_pt2))) && (state_rect != 2'b10)) begin
            rgb_temp <= (show_layer_1 || show_layer_2 || show_layer_3) ? stored_rgb_reg : 3'b111;
        end
        else begin
            case ({show_layer_1, show_layer_2, show_layer_3}) 
                3'b111: begin
                    if (layer1_color != 3'b111) begin
                        rgb_temp <= layer1_color; // Prefer layer 1 if it's not white
                    end else if (layer2_color != 3'b111) begin
                        rgb_temp <= layer2_color; // Prefer layer 2 if layer 1 is white
                    end else begin
                        rgb_temp <= layer3_color; // Fallback to layer 3 if both layer 1 and 2 are white
                    end
                end
                3'b110: rgb_temp <= (layer1_color == 3'b111) ? layer2_color : layer1_color; 
                3'b101: rgb_temp <= (layer1_color == 3'b111) ? layer3_color : layer1_color; 
                3'b100: rgb_temp <= layer1_color; 
                3'b011: rgb_temp <= (layer2_color == 3'b111) ? layer3_color : layer2_color; 
                3'b010: rgb_temp <= layer2_color; 
                3'b001: rgb_temp <= layer3_color; 
                3'b000: rgb_temp <= 3'b111; 
                default: rgb_temp <= 3'b111; 
            endcase
        end
    end

endmodule