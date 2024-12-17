module LayerWritingEnable(
    input video_on,
    input [9:0] x, y,
    input [9:0] cursor_x, cursor_y,
    input [1:0] cursor_size,
    input draw_layer1_en, draw_layer2_en, draw_layer3_en,
    input reset,          // Reset signal
    input eraser,         // Eraser signal
    output reg we_layer1, we_layer2, we_layer3
);
    initial begin
        we_layer1 = 0;
        we_layer2 = 0;
        we_layer3 = 0;
    end
    
    always @(*) begin
        // Default write enables to 0
        we_layer1 = 0;
        we_layer2 = 0;
        we_layer3 = 0;

        // Reset functionality
        if (reset) begin
            we_layer1 = 1;
            we_layer2 = 1;
            we_layer3 = 1;
        end else if (video_on) begin
            // Eraser functionality
            if (eraser) begin
                we_layer1 = draw_layer1_en;
                we_layer2 = draw_layer2_en;
                we_layer3 = draw_layer3_en;
            end else begin
                case (cursor_size)
                    2'b00: begin
                        we_layer1 = draw_layer1_en && (x >= cursor_x && x < cursor_x + 4 && y >= cursor_y && y < cursor_y + 4);
                        we_layer2 = draw_layer2_en && (x >= cursor_x && x < cursor_x + 4 && y >= cursor_y && y < cursor_y + 4);
                        we_layer3 = draw_layer3_en && (x >= cursor_x && x < cursor_x + 4 && y >= cursor_y && y < cursor_y + 4);
                    end
                    2'b01: begin
                        we_layer1 = draw_layer1_en && (x >= cursor_x && x < cursor_x + 8 && y >= cursor_y && y < cursor_y + 8);
                        we_layer2 = draw_layer2_en && (x >= cursor_x && x < cursor_x + 8 && y >= cursor_y && y < cursor_y + 8);
                        we_layer3 = draw_layer3_en && (x >= cursor_x && x < cursor_x + 8 && y >= cursor_y && y < cursor_y + 8);
                    end
                    2'b10: begin
                        we_layer1 = draw_layer1_en && (x >= cursor_x && x < cursor_x + 20 && y >= cursor_y && y < cursor_y + 20);
                        we_layer2 = draw_layer2_en && (x >= cursor_x && x < cursor_x + 20 && y >= cursor_y && y < cursor_y + 20);
                        we_layer3 = draw_layer3_en && (x >= cursor_x && x < cursor_x + 20 && y >= cursor_y && y < cursor_y + 20);
                    end
                    default: ; // Default case
                endcase
            end
        end
    end
endmodule