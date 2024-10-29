module swap(
   output reg [7:0] A,
   output reg [7:0] B,
   input trigger,
   input [3:0] op
);

   always @(posedge trigger) begin
      if (op == 4'b1110) begin
         A <= A^B;
         B <= A^B;
         A <= A^B;
      end
   end

endmodule
