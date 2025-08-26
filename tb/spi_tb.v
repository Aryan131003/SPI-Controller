module spi_tb(

    );
    reg clk;
    reg reset;
    reg [15:0] data_in;
    wire spi_cs_l;
    wire spi_sclk;
    wire spi_data;
    wire [4:0]counter;

    // Instantiate DUT
    spi_protocol dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .spi_cs_l(spi_cs_l),
        .spi_sclk(spi_sclk),
        .spi_data(spi_data),
        .counter(counter)
    );

    // Clock generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        data_in = 16'h5555;  // Example data (1010_0101_1111_0000)
        #20 reset = 0;       // Release reset after 20ns

        // Let it run
        #500;

        // Load new data
        data_in = 16'h1234;
        #500;

        $finish;
    end

endmodule