`timescale 1ns / 1ps

module tb_gray_binary;

parameter N = 4;

reg  [N-1:0] in;
reg  mode;
wire [N-1:0] out;

gray_binary_converter #(.N(N)) DUT (
    .in(in),
    .mode(mode),
    .out(out)
);

integer i;
reg [N-1:0] expected;
reg [N-1:0] temp;

initial begin

    $display("Binary -> Gray Conversion");

    mode = 0;

    for(i = 0; i < (1<<N); i = i + 1) begin

        in = i;
        #10;

        // Expected Gray Calculation
        expected[N-1] = in[N-1];
        expected[N-2:0] = in[N-1:1] ^ in[N-2:0];

        $display("Decimal=%0d | Binary=%b | Gray=%b",
                  i, in, out);

        if(out !== expected)
            $display("ERROR at %0d", i);
    end
  
    $display(" Gray -> Binary Conversion");

    mode = 1;

    for(i = 0; i < (1<<N); i = i + 1) begin

        // Generate Gray code input
        in = (i >> 1) ^ i;
        #10;

        // Expected Binary Reconstruction
        temp[N-1] = in[N-1];

        for(integer j=N-2; j>=0; j=j-1)
            temp[j] = temp[j+1] ^ in[j];

        $display("Decimal=%0d | Gray=%b | Binary=%b",
                  i, in, out);

        if(out !== temp)
            $display("ERROR at Gray input %b", in);
    end

    $display(" Exhaustive Testing Complete");
    $finish;

end

endmodule
