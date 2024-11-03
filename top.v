module top(
   input [15:0] sw,
   input btnC,          // Control button (e.g., reset)
   input btnU,          // Trigger button
   input clk,           // Main clock signal
   output [15:0] led,   // LEDs to display A and B register values
   output [3:0] an,     // Seven-segment anodes
   output [6:0] seg     // Seven-segment segments
);

   // Define internal signals
   wire [7:0] A;             // Register output A
   wire [7:0] B;             // Register output B
   wire [7:0] Y;             // Output from ALU
   wire [3:0] OP;            // Operation selector from switches
   wire slow_clock;          // Slow clock signal for display scanning
   wire load_a, load_b, swap, reset; // Control signals for Registers module

   // Assign operation selector from switches
   assign OP = sw[3:0];

   // Connect LEDs to display contents of A and B registers
   assign led[15:8] = A;     // Upper 8 LEDs display register A
   assign led[7:0] = B;      // Lower 8 LEDs display register B

   // Instantiate ALU core (removed 'external' port connection)
   ALU alu(
      .A(A),
      .B(B),
      .op(OP),
      .trigger(btnU),    // Trigger ALU operation on button press
      .Y(Y)              // ALU result
   );

   // Instantiate Registers module
   Registers registers(
      .data_in(sw[15:8]), // 8-bit input from switches
      .load_a(load_a),    // Load signal for register A
      .load_b(load_b),    // Load signal for register B
      .swap(swap),        // Swap control for A and B
      .reset(reset),      // Reset control signal
      .clk(clk),          // System clock
      .A(A),              // Register output A
      .B(B)               // Register output B
   );

   // Set control signals based on OP code
   assign load_a = (OP == 4'b1111);      // Load into A when OP is 1111
   assign load_b = (OP == 4'b1101);      // Load into B when OP is 1101
   assign swap   = (OP == 4'b1110);      // Swap A and B when OP is 1110
   assign reset  = btnC;                 // Reset when btnC is pressed

   // Clock Divider to create a slower clock for display multiplexing
   clock_div #(.BIT_COUNT(16)) count(
      .clock(clk),
      .reset(btnU),
      .div_clock(slow_clock)
   );

   // Seven-Segment Display Scanner
   seven_seg_scanner sss(
      .div_clock(slow_clock), // Use the slow clock for segment scanning
      .reset(btnU),           // Reset on btnU press
      .anode(an)              // Anode control for multiplexed seven-segment display
   );

   // Seven-Segment Display Decoder
   seven_seg_decoder ssd(
      .Y(Y),                  // Display the ALU result on segments
      .OP(OP),                // Display the operation selector
      .anode(an),             // Anode control
      .segs(seg)              // Segment output for seven-segment display
   );

endmodule

