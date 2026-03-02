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

module power_of_two_structural(
    input  [15:0] x,
    output po2
);

wire [15:0] x_minus_one;
wire [15:0] and_result;
wire zero_check;
wire nonzero_check;

// Compute x - 1 
assign x_minus_one = x - 16'b1;

// AND result
assign and_result = x & x_minus_one;

// Reduction NOR gives 1 if all bits are 0
assign zero_check = ~(|and_result);

// Ensure input is not zero
assign nonzero_check = |x;

// Final output
assign po2 = zero_check & nonzero_check;

endmodule
