module ALU (
    input [7:0] A, B,
    input [3:0] op, // Operation selector
    output reg [7:0] Y
);
    always @(*) begin
        case (op)
            4'b0000: Y = A + B;           // ADD
            4'b0001: Y = A - B;           // SUB
            4'b0010: Y = A << 1;          // Shift left
            4'b0011: Y = A >> 1;          // Shift right
            4'b0100: Y = (A == B) ? 0 : (A > B ? 1 : -1); // Comparison
            4'b0101: Y = A & B;           // AND
            4'b0110: Y = A | B;           // OR
            4'b0111: Y = A ^ B;           // XOR
            4'b1000: Y = ~(A & B);        // NAND
            4'b1001: Y = ~(A | B);        // NOR
            4'b1010: Y = ~(A ^ B);        // XNOR
            4'b1011: Y = ~A;              // NOT
            4'b1100: Y = -A;              // Two’s Complement
            4'b1101: Y = A;               // Store A in Y (for Store A operation)
            4'b1110: begin                // Swap A and B
                Y = B;
                B = A;
            end
            4'b1111: Y = A;               // Load A with switches (handled externally)
            default: Y = 8'b0;
        endcase
    end
endmodule
