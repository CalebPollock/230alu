module multiplexer(
   input [3:0]op,
   output reg [15:0]active
);

   always @(*) begin
      case (op)
          0: active = 16b'0000000000000001
          1: active = 16b'0000000000000010
          2: active = 16b'0000000000000100
          3: active = 16b'0000000000001000
          4: active = 16b'0000000000010000
          5: active = 16b'0000000000100000
          6: active = 16b'0000000001000000
          7: active = 16b'0000000010000000
          8: active = 16b'0000000100000000
          9: active = 16b'0000001000000000
         10: active = 16b'0000010000000000
         11: active = 16b'0000100000000000
         12: active = 16b'0001000000000000
         13: active = 16b'0010000000000000
         14: active = 16b'0100000000000000
         15: active = 16b'1000000000000000
      endcase
   end

endmodule
