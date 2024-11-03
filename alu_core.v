module ALU (
    input [7:0] A, B,
    input trigger,
    input [3:0] op, // Operation selector
    output reg [7:0] Y
);

    // Intermediate wires for addition and two's complement
    wire [7:0] add_result;
    wire [7:0] twos_compl_result;
    wire [7:0] add_carry;
    wire [7:0] twos_carry;

    // Use full_adder instances for 8-bit addition
    full_adder fa0 (.A(A[0]), .B(B[0]), .Cin(1'b0),        .Y(add_result[0]), .Cout(add_carry[0]));
    full_adder fa1 (.A(A[1]), .B(B[1]), .Cin(add_carry[0]), .Y(add_result[1]), .Cout(add_carry[1]));
    full_adder fa2 (.A(A[2]), .B(B[2]), .Cin(add_carry[1]), .Y(add_result[2]), .Cout(add_carry[2]));
    full_adder fa3 (.A(A[3]), .B(B[3]), .Cin(add_carry[2]), .Y(add_result[3]), .Cout(add_carry[3]));
    full_adder fa4 (.A(A[4]), .B(B[4]), .Cin(add_carry[3]), .Y(add_result[4]), .Cout(add_carry[4]));
    full_adder fa5 (.A(A[5]), .B(B[5]), .Cin(add_carry[4]), .Y(add_result[5]), .Cout(add_carry[5]));
    full_adder fa6 (.A(A[6]), .B(B[6]), .Cin(add_carry[5]), .Y(add_result[6]), .Cout(add_carry[6]));
    full_adder fa7 (.A(A[7]), .B(B[7]), .Cin(add_carry[6]), .Y(add_result[7]), .Cout(add_carry[7]));

    // Instantiate two's complement module
    twos_compliment tc(.A(A), .Y(twos_compl_result));

    always @(posedge trigger) begin
        case (op)
            4'b0000: Y <= add_result;               // ADD using full_adder chain
            4'b0001: Y <= A - B;                    // SUB
            4'b0010: Y <= A << 1;                   // Shift left
            4'b0011: Y <= A >> 1;                   // Shift right
            4'b0100: Y <= (A == B) ? 0 : (A > B ? 1 : -1); // Comparison
            4'b0101: Y <= A & B;                    // AND
            4'b0110: Y <= A | B;                    // OR
            4'b0111: Y <= A ^ B;                    // XOR
            4'b1000: Y <= ~(A & B);                 // NAND
            4'b1001: Y <= ~(A | B);                 // NOR
            4'b1010: Y <= ~(A ^ B);                 // XNOR
            4'b1011: Y <= ~A;                       // NOT
            4'b1100: Y <= twos_compl_result;        // Two’s Complement using full_adder chain
            4'b1101: Y <= A;                        // Store A in Y (for Store A operation)
            default: Y <= 8'b00000000;              // Default case
        endcase
    end

endmodule



