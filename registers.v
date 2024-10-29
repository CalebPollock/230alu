module Registers (
    input [7:0] data_in,
    input load_a, load_b, swap, reset, clk,
    output reg [7:0] A, B
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'b0;
            B <= 8'b0;
        end else if (load_a) begin
            A <= data_in;
        end else if (load_b) begin
            B <= data_in;
        end else if (swap) begin
            A <= B;
            B <= A;
        end
    end
endmodule
