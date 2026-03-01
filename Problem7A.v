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

module parameter_alu #(
    parameter N = 32 // Default bit width
)(
    input  [N-1:0] a,
    input  [N-1:0] b,
    input  [2:0]   op,

    output reg [N-1:0] result,
    output reg cmp_eq,
    output reg cmp_lt,
    output reg cmp_gt
);

    // Operation Codes
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR  = 3'b011;
    localparam XOR = 3'b100;
    localparam CMP = 3'b101;

    always @(*) begin
        // Default assignments to avoid latches
        result = {N{1'b0}};
        cmp_eq = 1'b0;
        cmp_lt = 1'b0;
        cmp_gt = 1'b0;

        case (op)
        ADD: result = a + b;
        SUB: result = a - b;
        AND: result = a & b;
        OR:  result = a | b;
        XOR: result = a ^ b;
        CMP: begin
            cmp_eq = (a == b);
            cmp_lt = ($signed(a) < $signed(b));
            cmp_gt = ($signed(a) > $signed(b));
    	end
      	default: result = {N{1'b0}};
      endcase
    end
endmodule
