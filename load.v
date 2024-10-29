module load(
   output reg [7:0] A,
   input trigger,
   input [3:0] op,
   input [7:0] external
);

   always @(posedge trigger) begin
      if (op == 4'b1111) begin
         A <= external;
      end
   end

endmodule
