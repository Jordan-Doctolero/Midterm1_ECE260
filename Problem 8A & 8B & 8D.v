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

module mux_tree #(
    parameter N = 16,     // Must be power of 2
    parameter W = 8
)(
    input  wire [N*W-1:0] in,
    input  wire [$clog2(N)-1:0] sel,
    output wire [W-1:0] out
);

    //8B Part
    initial begin
        if (N & (N-1))
            $error("N must be power of 2");
    end

generate
    // Base case: 2-to-1 MUX
    if (N == 2) begin : leaf
        assign out = sel[0] ? in[2*W-1:W] : in[W-1:0];
    end
    else begin : node
        localparam HALF = N / 2;

        wire [W-1:0] left_out;
        wire [W-1:0] right_out;

        mux_tree #(.N(HALF), .W(W)) left (
            .in(in[HALF*W-1:0]),
            .sel(sel[$clog2(N)-2:0]),
            .out(left_out)
        );

        mux_tree #(.N(HALF), .W(W)) right (
            .in(in[N*W-1:HALF*W]),
            .sel(sel[$clog2(N)-2:0]),
            .out(right_out)
        );

        assign out = sel[$clog2(N)-1] ? right_out : left_out;
    end
endgenerate

endmodule

