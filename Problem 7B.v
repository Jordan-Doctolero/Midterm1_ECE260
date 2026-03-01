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
        3'b101: begin // Equal
            cmp_res = (A == B);
        end
        3'b110: begin // Greater than
            cmp_res = (A > B);
        end
        3'b111: begin // Less than
            cmp_res = (A < B);
        end
    endcase
end
endmodule


