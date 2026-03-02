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

module encoder_4to2 (
    input  [3:0] D,      // 4 input lines
    output [1:0] Y,      // 2-bit encoded output
    output       Valid   // Valid signal
);
    assign Valid = |D;   // OR of all inputs
    
    assign Y[1] = D[3] | D[2];
    assign Y[0] = D[3] | (D[1] & ~D[2]);
endmodule

module encoder_32to5 (
    input  [31:0] D,     // 32 input lines
    output [4:0]  Y,     // 5-bit encoded output  
    output        Valid  // Valid signal
);
    // Internal wires for Level 1
    wire [1:0] Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7;
    wire V0, V1, V2, V3, V4, V5, V6, V7;
    
    // Internal wires for Level 2
    wire [1:0] G0, G1;
    wire VG0, VG1;
    
    // Internal wires for Level 3
    wire [1:0] G2;
    
    // Level 1: 8 × 4→2 encoders
    encoder_4to2 ENC0 (.D(D[3:0]),   .Y(Y0), .Valid(V0));
    encoder_4to2 ENC1 (.D(D[7:4]),   .Y(Y1), .Valid(V1));
    encoder_4to2 ENC2 (.D(D[11:8]),  .Y(Y2), .Valid(V2));
    encoder_4to2 ENC3 (.D(D[15:12]), .Y(Y3), .Valid(V3));
    encoder_4to2 ENC4 (.D(D[19:16]), .Y(Y4), .Valid(V4));
    encoder_4to2 ENC5 (.D(D[23:20]), .Y(Y5), .Valid(V5));
    encoder_4to2 ENC6 (.D(D[27:24]), .Y(Y6), .Valid(V6));
    encoder_4to2 ENC7 (.D(D[31:28]), .Y(Y7), .Valid(V7));
    
    // Level 2: 2 × 4→2 encoders
    encoder_4to2 ENC8 (.D({V3,V2,V1,V0}), .Y(G0), .Valid(VG0));
    encoder_4to2 ENC9 (.D({V7,V6,V5,V4}), .Y(G1), .Valid(VG1));
    
    // Level 3: 1 × 4→2 encoder
    encoder_4to2 ENC10 (.D({2'b00,VG1,VG0}), .Y(G2), .Valid(Valid));
    
    // Output multiplexing logic
    assign Y[4:3] = G2[1:0];
    
    // MUX for Y[2:1]
    assign Y[2:1] = G2[0] ? G1[1:0] : G0[1:0];
    
    // 8:1 MUX for Y[0] (LSB from appropriate Level 1 encoder)
    reg Y0_bit;
    always @(*) begin
        case({G2[0], Y[2:1]})
            3'b000: Y0_bit = Y0[0];
            3'b001: Y0_bit = Y1[0];
            3'b010: Y0_bit = Y2[0];
            3'b011: Y0_bit = Y3[0];
            3'b100: Y0_bit = Y4[0];
            3'b101: Y0_bit = Y5[0];
            3'b110: Y0_bit = Y6[0];
            3'b111: Y0_bit = Y7[0];
        endcase
    end
    assign Y[0] = Y0_bit;
    
endmodule
