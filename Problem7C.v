module tb_alu;

parameter N = 8;

reg [N-1:0] A;
reg [N-1:0] B;
reg [2:0] opcode;

wire [N-1:0] result;
wire cmp_res;

parameter ADD = 3'b000;
parameter SUB = 3'b001;
parameter AND = 3'b010;
parameter OR  = 3'b011;
parameter XOR = 3'b100;
parameter EQ  = 3'b101;
parameter GT  = 3'b110;
parameter LT  = 3'b111;

parameter TESTS = 1000;

integer i;
reg [N-1:0] expected_result;
reg expected_cmp;

parameterized_alu #(.N(N)) DUT(
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .cmp_res(cmp_res)
);

initial begin
    for(i = 0; i < TESTS; i = i + 1) begin

        A = $random;
        B = $random;
        opcode = $random % 8;

        #5;

        // Self-check
        case(opcode)

            ADD: expected_result = A + B;
            SUB: expected_result = A - B;
            AND: expected_result = A & B;
            OR : expected_result = A | B;
            XOR: expected_result = A ^ B;

            EQ: expected_cmp = (A == B);
            GT: expected_cmp = (A > B);
            LT: expected_cmp = (A < B);

        endcase

        if(opcode <= 3'b100) begin
            if(result !== expected_result) begin
                $display("ERROR result mismatch");
                $stop;
            end
        end
        else begin
            if(cmp_res !== expected_cmp) begin
                $display("ERROR compare mismatch");
                $stop;
            end
        end
    end

    $display("Random test passed!");
    $finish;
end

endmodule
