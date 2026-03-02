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

module gray_binary_converter #(
    parameter N = 4
)(
    input  [N-1:0] in,
    input mode,
    output reg [N-1:0] out
);

integer i;

always @(*) begin
    if(mode == 0) begin
        // Binary -> Gray
        out[N-1] = in[N-1];
        for(i = N-2; i >= 0; i = i-1) begin
            out[i] = in[i+1] ^ in[i];
        end
    end
    else begin
        // Gray -> Binary
        out[N-1] = in[N-1];
        for(i = N-2; i >= 0; i = i-1) begin
            out[i] = out[i+1] ^ in[i];
        end
    end
end
endmodule
