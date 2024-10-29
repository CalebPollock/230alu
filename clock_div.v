module clock_div
#(
    parameter BIT_COUNT = 17
)
(
    input clock,
    input reset,
    output reg div_clock
);

   wire [BIT_COUNT:0]interm [1:0];

   assign interm[0][0] = clock;

   genvar i;
   generate
      for (i = 0; i < BIT_COUNT; i = i+1) begin
         dff x(
            .reset(reset),
            .clock(interm[0][i]),
            .D(interm[1][i]),
            .Q(interm[0][i+1]),
            .NotQ(interm[1][i])
         );
      end
   endgenerate
    
   always @(*) begin
      div_clock <= interm[0][BIT_COUNT];
   end

endmodule
