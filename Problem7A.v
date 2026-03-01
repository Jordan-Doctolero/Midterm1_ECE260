module parameterized_alu #(
    parameter N = 8
)(
    input  [N-1:0] A,
    input  [N-1:0] B,
    input  [2:0] opcode,

    output reg [N-1:0] result,
    output reg cmp_res
);

    always @(*) begin
    result  = {N{1'b0}};
    cmp_res = 1'b0;

    case (opcode)
        3'b000: result = A + B;
        3'b001: result = A - B;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = A ^ B;
        3'b101: cmp_res = (A == B);
        3'b110: cmp_res = (A > B);
        3'b111: cmp_res = (A < B);
        default: begin
            result  = {N{1'b0}};
            cmp_res = 1'b0;
        end
    endcase
end
endmodule
