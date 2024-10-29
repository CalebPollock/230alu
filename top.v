module top(
   input [15:0] sw,
   input btnC,
   input btnU,
   input clk,
   output [15:0] led,
   output [3:0] an,
   output [6:0] seg
);

   wire [7:0]Y;
   wire [3:0]OP;
   wire slow_clock;

   // Divide the clock, outputing a much slower
   // one
   clock_div #(.BIT_COUNT(16)) count(
      .clock(clk),
      .reset(btnU),
      .div_clock(slow_clock)
   );

   // Iterativly select over each anode in
   // the segment display. Tick based on the
   // slow_clock from clock_div
   seven_seg_scanner sss(
      .div_clock(slow_clock),
      .reset(btnU),
      .anode(an)
   );


   // Display a given value based on the selected
   // anode. OP is shown on an[0] and Y is on an[3:2].
   seven_seg_decoder ssd(
      .Y(Y),
      .OP(OP),
      .anode(an),
      .segs(seg)
   );

endmodule
