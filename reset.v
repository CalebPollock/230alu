module reset(
   output reg [7:0] A,
   output reg [7:0] B,
   output reg [7:0] Y,
   input trigger
);

   always @(trigger) begin
      A <= 0;
      B <= 0;
      Y <= 0;
   end

endmodule
