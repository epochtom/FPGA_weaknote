module ELEC4320_VGA(
    input clk_100MHz,      // from FPGA
    input sw_red,          // 1 bit for red color
    input sw_green,        // 1 bit for green color
    input sw_blue,         // 1 bit for blue color
    input sw_up,           // button to move cursor up
    input sw_down,         // button to move cursor down
    input sw_left,         // button to move cursor left
    input sw_right,        // button to move cursor right
    input sw_size,         // button to change cursor size
    input eraser,          // switch
    input reset,           // switch
    input draw_layer1_en,  // switch
    input draw_layer2_en,  // switch
    input show_layer_3,    // switch
    input draw_layer3_en,  // switch
    input show_layer_1,    // switch
    input show_layer_2,    // switch
    input record_rect_pt,  // switch
    input draw_rectangle,  // switch
    input control_speed_cursor,
    output hsync, 
    output vsync,
    output [2:0] rgb,      // 3 FPGA pins for RGB (1 per color)
    output [1:0] rect_state_led,
    output separate_1,
    output separate_2
);

    // Signal Declaration
    reg [2:0] stored_rgb_reg;    // Register to store the color when enable is pressed
    wire [9:0] cursor_x, cursor_y; // Register for cursor position
    wire video_on;               // Same signal as in controller
    wire [9:0] x, y;             // Current pixel coordinates

    // Slower clock signals
    wire slow_clk1;               // Slower clock signal 1
    wire slow_clk2;               // Even slower clock signal 2

    // Cursor size state machine
    wire [1:0] cursor_size;       // 2-bit register to store cursor size state

    // BRAM Signals
    wire [2:0] layer1_color;
    wire [2:0] layer2_color;
    wire [2:0] layer3_color;
    
    reg [18:0] addr;            // Larger address bus to match the updated Layer_BRAM
    wire we_layer1, we_layer2, we_layer3; // Write enable signal for BRAM
    wire selected_clk = control_speed_cursor ? slow_clk1 : slow_clk2;

    // Instantiate rectangle_drawing module
    wire [9:0] recg_x_pt1, recg_y_pt1, recg_x_pt2, recg_y_pt2;
    wire [1:0] state_rect;
    wire [2:0] rgb_temp; 

    initial begin
        stored_rgb_reg = 3'b000;
    end
    
    // Instantiate CursorPositionController module
    CursorPositionController cursor_pos_ctrl (
        .clk(selected_clk),
        .cursor_size(cursor_size),
        .sw_up(sw_up),
        .sw_down(sw_down),
        .sw_left(sw_left),
        .sw_right(sw_right),
        .cursor_x(cursor_x),
        .cursor_y(cursor_y)
    );

    rectangle_drawing rect_draw (
        .clk(clk_100MHz),
        .record_rect_pt(record_rect_pt),
        .draw_rectangle(draw_rectangle),
        .cursor_x(cursor_x),
        .cursor_y(cursor_y),
        .x(x),
        .y(y),
        .recg_x_pt1(recg_x_pt1),
        .recg_y_pt1(recg_y_pt1),
        .recg_x_pt2(recg_x_pt2),
        .recg_y_pt2(recg_y_pt2),
        .state_rect(state_rect)
    );

    // Instantiate ClockDivider module
    ClockDivider clk_div (
        .clk_100MHz(clk_100MHz),
        .slow_clk1(slow_clk1),
        .slow_clk2(slow_clk2)
    );

    // Instantiate CursorSizeController module
    CursorSizeController cursor_size_ctrl (
        .clk(selected_clk),
        .sw_size(sw_size),
        .cursor_size(cursor_size)
    );

    // Instantiate LayerWritingEnable module
    LayerWritingEnable layer_write_enable (
        .video_on(video_on),
        .x(x),
        .y(y),
        .cursor_x(cursor_x),
        .cursor_y(cursor_y),
        .cursor_size(cursor_size),
        .draw_layer1_en(draw_layer1_en),
        .draw_layer2_en(draw_layer2_en),
        .draw_layer3_en(draw_layer3_en),
        .reset(reset),
        .eraser(eraser),
        .we_layer1(we_layer1),
        .we_layer2(we_layer2),
        .we_layer3(we_layer3)
    );

    VGA_Controller VGA1(.clk_100MHz(clk_100MHz), .hsync(hsync), .vsync(vsync),
                        .video_on(video_on), .p_tick(), .x(x), .y(y));

    Layer_BRAM layer_bram (
        .clk(clk_100MHz),
        .addr(addr),
        .data_in(stored_rgb_reg), // Use stored_rgb_reg for BRAM data input
        .we(we_layer1),           // Use local write enable signal
        .data_out(layer1_color)
    );
    
    Layer_BRAM layer_bram2 (
        .clk(clk_100MHz),
        .addr(addr),
        .data_in(stored_rgb_reg), // Use stored_rgb_reg for BRAM data input
        .we(we_layer2),           // Use we_layer2 for layer 2
        .data_out(layer2_color)
    );
    
    Layer_BRAM layer_bram3 (
        .clk(clk_100MHz),
        .addr(addr),
        .data_in(stored_rgb_reg), // Use stored_rgb_reg for BRAM data input
        .we(we_layer3),           // Use we_layer3 for layer 3
        .data_out(layer3_color)
    );

    // Assign stored_rgb_reg and handle reset and eraser logic
    always @(posedge clk_100MHz) begin
        if (reset || eraser)
            stored_rgb_reg = 3'b111;
        else 
            stored_rgb_reg <= {sw_red, sw_green, sw_blue};
        
        addr <= (y / 2 *  320) + x / 2;
    end

    VGA_Color_Showing vga_color_showing (
        .video_on(video_on),
        .x(x),
        .y(y),
        .stored_rgb_reg(stored_rgb_reg),
        .cursor_size(cursor_size),
        .cursor_x(cursor_x),
        .cursor_y(cursor_y),
        .recg_x_pt1(recg_x_pt1),
        .recg_y_pt1(recg_y_pt1),
        .recg_x_pt2(recg_x_pt2),
        .recg_y_pt2(recg_y_pt2),
        .state_rect(state_rect),
        .show_layer_1(show_layer_1),
        .show_layer_2(show_layer_2),
        .show_layer_3(show_layer_3),
        .layer1_color(layer1_color),
        .layer2_color(layer2_color),
        .layer3_color(layer3_color),
        .rgb_temp(rgb_temp) // Connect to the output of VGA_Color_Showing
    );

    assign rect_state_led = state_rect;  
    assign rgb = rgb_temp;
    
    // separate switch
    assign separate_1 = 1;
    assign separate_2 = 1;
    
endmodule