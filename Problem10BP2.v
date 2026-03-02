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

module power_of_two_behavioral(
    input  [15:0] x,
    output reg po2
);

always @(*) begin
    if (x != 0 && (x & (x - 1)) == 0)
        po2 = 1'b1;
    else
        po2 = 1'b0;
end

endmodule
