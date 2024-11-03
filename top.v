module top(
   input [15:0] sw,
   input btnC,
   input btnU,
   input clk,
   output [15:0] led,
   output [3:0] an,
   output [6:0] seg
);

   wire [7:0] A;             // Register output A
   wire [7:0] B;             // Register output B
   wire [7:0] Y;             // Output from ALU
   wire [3:0] OP;            // Operation selector
   wire slow_clock;

   // Control signals for the Registers module
   wire load_a, load_b, swap, reset;

   // Operation code from switches
   assign OP = sw[3:0];

   // LEDs to display contents of A and B
   assign led[15:8] = A;
   assign led[7:0] = B;

   // Instantiate ALU core
   ALU alu(
      .A(A),
      .B(B),
      .external(sw[15:8]),
      .trigger(btnU),
      .op(OP),
      .Y(Y)
   );

   // Instantiate Registers module
   Registers registers(
      .data_in(sw[15:8]),
      .load_a(load_a),
      .load_b(load_b),
      .swap(swap),
      .reset(btnC),
      .clk(clk),
      .A(A),
      .B(B)
   );

   // Set control signals based on OP code
   assign load_a = (OP == 4'b1111);      // Load into A
   assign load_b = (OP == 4'b1101);      // Store A in B (as per lab instructions)
   assign swap   = (OP == 4'b1110);      // Swap A and B
   assign reset  = btnC;                 // Reset when btnC is pressed

   // Clock Divider to slow down the display
   clock_div #(.BIT_COUNT(16)) count(
      .clock(clk),
      .reset(btnU),
      .div_clock(slow_clock)
   );

   // Seven-Segment Display Scanner
   seven_seg_scanner sss(
      .div_clock(slow_clock),
      .reset(btnU),
      .anode(an)
   );

   // Seven-Segment Display Decoder
   seven_seg_decoder ssd(
      .Y(Y),
      .OP(OP),
      .anode(an),
      .segs(seg)
   );

endmodule

