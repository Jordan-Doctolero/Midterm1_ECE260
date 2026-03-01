`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 12:26:30 AM
// Design Name: 
// Module Name: Midterm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

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
        // Default assignments prevent latches
        result  = {N{1'b0}};
        cmp_res = 1'b0;

        unique case (opcode)

            3'b000: result = A + B;          // ADD
            3'b001: result = A - B;          // SUB
            3'b010: result = A & B;          // AND
            3'b011: result = A | B;          // OR
            3'b100: result = A ^ B;          // XOR

            3'b101: cmp_res = (A == B);      // Equal
            3'b110: cmp_res = (A > B);       // Greater
            3'b111: cmp_res = (A < B);       // Less

            default: begin
                result  = {N{1'b0}};
                cmp_res = 1'b0;
            end

        endcase
    end

endmodule
