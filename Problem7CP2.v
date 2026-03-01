`timescale 1ns / 1ps

module parameter_alu_tb;

    parameter N = 8;

    reg [N-1:0] a;
    reg [N-1:0] b;
    reg [2:0] op;

    wire [N-1:0] result;
    wire cmp_eq;
    wire cmp_lt;
    wire cmp_gt;

    parameter_alu #(.N(N)) dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .cmp_eq(cmp_eq),
        .cmp_lt(cmp_lt),
        .cmp_gt(cmp_gt)
    );

    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR  = 3'b011;
    localparam XOR = 3'b100;
    localparam CMP = 3'b101;

    initial begin
        $display("ALU TEST START");

        a = 8'd20;
        b = 8'd10;

        op = ADD;
        #10;
        $display("ADD : %0d + %0d = %0d | %b + %b = %b",
                 a, b, result,
                 a, b, result);

        op = SUB;
        #10;
        $display("SUB : %0d - %0d = %0d | %b - %b = %b",
                 a, b, result,
                 a, b, result);

        op = AND;
        #10;
        $display("AND : %0d & %0d = %0d | %b & %b = %b",
                 a, b, result,
                 a, b, result);

        op = OR;
        #10;
        $display("OR  : %0d | %0d = %0d | %b | %b = %b",
                 a, b, result,
                 a, b, result);

        op = XOR;
        #10;
        $display("XOR : %0d ^ %0d = %0d | %b ^ %b = %b",
                 a, b, result,
                 a, b, result);

        op = CMP;
        a = 8'd15;
        b = 8'd15;
        #10;
        $display("CMP EQ | a=%0d b=%0d | eq=%b lt=%b gt=%b",
                 a, b, cmp_eq, cmp_lt, cmp_gt);

        a = 8'd5;
        b = 8'd20;
        #10;
        $display("CMP LT | a=%0d b=%0d | eq=%b lt=%b gt=%b",
                 a, b, cmp_eq, cmp_lt, cmp_gt);

        a = 8'd30;
        b = 8'd10;
        #10;
        $display("CMP GT | a=%0d b=%0d | eq=%b lt=%b gt=%b",
                 a, b, cmp_eq, cmp_lt, cmp_gt);

        $display("ALU TEST COMPLETE");
        $finish;
    end

endmodule
