module top(
   input [15:0] sw,
   input btnC,
   input btnU,
   input clk,
   output [15:0] led,
   output [3:0] an,
   output [6:0] seg
);

   wire [7:0]A;
   wire [7:0]B;
   
   wire [7:0]Y;
   wire [3:0]OP;
   wire slow_clock;

   wire enable_a;

   assign led[15:8] = A;
   assign led[7:0] = B;
   assign OP = sw[3:0];

   ALU alu(
      .A(A),
      .B(B),
      .external(sw[15:8]),
      .trigger(btnU),
      .op(OP),
      .Y(Y)
   );

   swap SWAP(
      .A(A),
      .B(B),
      .trigger(btnU),
      .op(OP)
   );

   load LOAD(
      .A(A),
      .external(sw[15:8]),
      .trigger(btnU),
      .op(OP)
   );

   reset RESET(
      .A(A),
      .B(B),
      .Y(Y),
      .trigger(btnC)
   );


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
