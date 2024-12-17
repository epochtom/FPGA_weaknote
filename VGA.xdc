# Clock signal
set_property PACKAGE_PIN W5 [get_ports {clk_100MHz}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100MHz}]
# VGA colour
set_property PACKAGE_PIN N19 [get_ports {rgb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]
set_property PACKAGE_PIN D17 [get_ports {rgb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]
set_property PACKAGE_PIN J18 [get_ports {rgb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]
# VGA sync signals
set_property PACKAGE_PIN P19 [get_ports {hsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {hsync}]
set_property PACKAGE_PIN R19 [get_ports {vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]
# Switches for RGB colors
set_property PACKAGE_PIN V17 [get_ports {sw_red}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_red}]
set_property PACKAGE_PIN V16 [get_ports {sw_green}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_green}]
set_property PACKAGE_PIN W16 [get_ports {sw_blue}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_blue}]
# Button to control cursor movement
set_property PACKAGE_PIN T18 [get_ports {sw_up}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_up}]
set_property PACKAGE_PIN U17 [get_ports {sw_down}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_down}]
set_property PACKAGE_PIN W19 [get_ports {sw_left}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_left}]
set_property PACKAGE_PIN T17 [get_ports {sw_right}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_right}]
set_property PACKAGE_PIN U18 [get_ports {sw_size}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_size}]
# Switch for layer write enable and whether to show layer or not
set_property PACKAGE_PIN R2 [get_ports {draw_layer1_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {draw_layer1_en}]
set_property PACKAGE_PIN T1 [get_ports {draw_layer2_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {draw_layer2_en}]
set_property PACKAGE_PIN U1 [get_ports {draw_layer3_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {draw_layer3_en}]

set_property PACKAGE_PIN W2 [get_ports {show_layer_1}]
set_property IOSTANDARD LVCMOS33 [get_ports {show_layer_1}]
set_property PACKAGE_PIN R3 [get_ports {show_layer_2}]
set_property IOSTANDARD LVCMOS33 [get_ports {show_layer_2}]
set_property PACKAGE_PIN T2 [get_ports {show_layer_3}]
set_property IOSTANDARD LVCMOS33 [get_ports {show_layer_3}]

# Switches for correction or reset
set_property PACKAGE_PIN W17 [get_ports {eraser}]
set_property IOSTANDARD LVCMOS33 [get_ports {eraser}]
set_property PACKAGE_PIN W15 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
# Switches for drawing rectangles
set_property PACKAGE_PIN W13 [get_ports {record_rect_pt}]
set_property IOSTANDARD LVCMOS33 [get_ports {record_rect_pt}]
set_property PACKAGE_PIN W14 [get_ports {draw_rectangle}]
set_property IOSTANDARD LVCMOS33 [get_ports {draw_rectangle}]

# Switches for changing cursor speed
set_property PACKAGE_PIN V2 [get_ports {control_speed_cursor}]
set_property IOSTANDARD LVCMOS33 [get_ports {control_speed_cursor}]
# LED to indicate rectangle drawing function
set_property PACKAGE_PIN E19 [get_ports {rect_state_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rect_state_led[1]}]
set_property PACKAGE_PIN U16 [get_ports {rect_state_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rect_state_led[0]}]

# separate LED
set_property PACKAGE_PIN V3 [get_ports {separate_1}]
set_property IOSTANDARD LVCMOS33 [get_ports {separate_1}]
set_property PACKAGE_PIN U15 [get_ports {separate_2}]
set_property IOSTANDARD LVCMOS33 [get_ports {separate_2}]
#set_property PACKAGE_PIN V13 [get_ports {separate_3}]
#set_property IOSTANDARD LVCMOS33 [get_ports {separate_3}]

#set_property PACKAGE_PIN U15 [get_ports {separate_4}]
#set_property IOSTANDARD LVCMOS33 [get_ports {separate_4}]

#set_property PACKAGE_PIN V14 [get_ports {separate_5}]
#set_property IOSTANDARD LVCMOS33 [get_ports {separate_5}]
#set_property PACKAGE_PIN U14 [get_ports {separate_6}]
#set_property IOSTANDARD LVCMOS33 [get_ports {separate_6}]
