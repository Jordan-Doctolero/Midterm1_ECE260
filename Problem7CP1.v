`timescale 1ns / 1ps

module parameter_alu_tb;

    // Parameters
    parameter N = 8;

    // Testbench signals
    reg [N-1:0] a;
    reg [N-1:0] b;
    reg [2:0] op;

    wire [N-1:0] result;
    wire cmp_eq;
    wire cmp_lt;
    wire cmp_gt;

    // Instantiate ALU
    parameter_alu #(.N(N)) dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .cmp_eq(cmp_eq),
        .cmp_lt(cmp_lt),
        .cmp_gt(cmp_gt)
    );

    // Operation codes (match ALU)
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR  = 3'b011;
    localparam XOR = 3'b100;
    localparam CMP = 3'b101;

    // Test sequence
    initial begin
        $display("Starting ALU Testbench");

        // Test values
        a = 8'd20;
        b = 8'd10;

        // ADD
        op = ADD;
        #10;
        $display("ADD: %d + %d = %d", a, b, result);

        // SUB
        op = SUB;
        #10;
        $display("SUB: %d - %d = %d", a, b, result);

        // AND
        op = AND;
        #10;
        $display("AND: %b & %b = %b", a, b, result);

        // OR
        op = OR;
        #10;
        $display("OR: %b | %b = %b", a, b, result);

        // XOR
        op = XOR;
        #10;
        $display("XOR: %b ^ %b = %b", a, b, result);

        // CMP Equal
        op = CMP;
        a = 8'd15;
        b = 8'd15;
        #10;
        $display("CMP EQ: eq=%b lt=%b gt=%b", cmp_eq, cmp_lt, cmp_gt);

        // CMP Less Than
        a = 8'd5;
        b = 8'd20;
        #10;
        $display("CMP LT: eq=%b lt=%b gt=%b", cmp_eq, cmp_lt, cmp_gt);

        // CMP Greater Than
        a = 8'd30;
        b = 8'd10;
        #10;
        $display("CMP GT: eq=%b lt=%b gt=%b", cmp_eq, cmp_lt, cmp_gt);

        $finish;
    end

endmodule
