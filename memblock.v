module memblock(
   input Enable,
   input [7:0]D,
   output [7:0]Q,
   output [7:0]NotQ
);

   genvar i;
   generate 
      for (i = 0; i < 8; i = i + 1) begin
         dlatch inst(
            .Enable(Enable),
            .D(D[i]),
            .Q(Q[i]),
            .NotQ(NotQ[i])
         );
      end
   endgenerate
endmodule
