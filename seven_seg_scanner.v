module seven_seg_scanner(
    input div_clock,
    input reset,
    output [3:0] anode
);


   reg [1:0] intcount;

   always @(posedge reset or posedge div_clock) begin
      if (reset) begin
         intcount <= 0;
      end else begin
         intcount <= intcount+1;
       end
   end
   
   assign anode = (intcount[0] ? (intcount[1] ? 4'b0111 : 4'b1011) : (intcount[1] ? 4'b1101 : 4'b1110));

endmodule
