module twos_compliment(
   input [7:0] A,
   output [7:0] Y
);

   wire [7:0] carry;

   full_adder a1 (.A(~A[0]), .B(1'b0), .Cin(1'b1),        .Y(Y[0]), .Cout(carry[0]));
   full_adder a2 (.A(~A[1]), .B(1'b0), .Cin(carry[0]),    .Y(Y[1]), .Cout(carry[1]));
   full_adder a3 (.A(~A[2]), .B(1'b0), .Cin(carry[1]),    .Y(Y[2]), .Cout(carry[2]));
   full_adder a4 (.A(~A[3]), .B(1'b0), .Cin(carry[2]),    .Y(Y[3]), .Cout(carry[3]));
   full_adder a5 (.A(~A[4]), .B(1'b0), .Cin(carry[3]),    .Y(Y[4]), .Cout(carry[4]));
   full_adder a6 (.A(~A[5]), .B(1'b0), .Cin(carry[4]),    .Y(Y[5]), .Cout(carry[5]));
   full_adder a7 (.A(~A[6]), .B(1'b0), .Cin(carry[5]),    .Y(Y[6]), .Cout(carry[6]));
   full_adder a8 (.A(~A[7]), .B(1'b0), .Cin(carry[6]),    .Y(Y[7]), .Cout(carry[7]));

endmodule
