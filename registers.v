module Registers (
    input [7:0] data_in, Y,
    input load_a, load_b, swap, reset, clk, store,
    output reg [7:0] A, B
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'b0;
            B <= 8'b0;
        end else if (store) begin
            A <= Y;
        end else begin
            if (load_a) A <= data_in;
            if (load_b) B <= data_in;
            if (swap) begin
                A <= B;
                B <= A;
            end
        end
    end


endmodule
