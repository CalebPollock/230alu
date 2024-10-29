module dff(
    input reset,
    input clock,
    input D,
    output reg Q,
    output NotQ
);
    assign NotQ = ~Q;

    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else if (clock) begin
            Q <= D;
        end
    end
endmodule
