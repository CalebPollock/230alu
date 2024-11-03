module dlatch (
    input Enable,
    input D,
    output reg Q,
    output NotQ
);
    assign NotQ = ~Q;

    always @(*) begin
        if (Enable) begin
            Q <= D;
        end
    end
endmodule