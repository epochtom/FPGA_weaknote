# FPGA Drawing Board (WeakNote)

## Introduction
This project aims to develop an FPGA-based drawing tool that leverages the parallel processing capabilities of FPGAs (xc7a35tcpg236-1) to deliver a high-performance, feature-rich drawing platform. The drawing tool is designed to provide a responsive and natural drawing experience, as well as incorporate advanced capabilities such as smart shape recognition, layer management, and image import functionality.

## Key Features
- VGA Display Control: Manages the overall functionality of the VGA display system, including color selection, cursor control, and layer management.
- User Interaction: Interfaces with user inputs (switches and buttons) to control cursor movement, color selection, and drawing operations.
- Layer Management: Supports multiple layers for drawing, enabling complex graphics to be displayed on the screen.
- Rectangle Drawing: Allows users to draw rectangles on the display by recording and processing cursor positions.
- Responsive Cursor: Provides a customizable cursor with selectable sizes for a smooth and natural drawing experience.
- Clock Management: Utilizes slower clock signals for controlling cursor speed based on user preference.

## System Architecture
The project consists of the following core modules:

- ELEC4320_VGA: Manages the overall VGA display system.
- CursorPositionController: Controls the position and movement of the cursor.
- rectangle_drawing: Facilitates the drawing of rectangles.
- ClockDivider: Generates slower clock signals for timing-sensitive operations.
- CursorSizeController: Controls the size of the cursor.
- LayerWritingEnable: Manages the ability to write to different layers of the graphical display.
- VGA_Color_Showing: Responsible for rendering and displaying colors on the VGA screen.
- VGA_Controller: Generates the necessary timing signals and control signals for the VGA display.
- Layer_BRAM: Provides a dedicated block of RAM for storing pixel data for different layers.
