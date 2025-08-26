module spi_protocol(
    input wire clk, //System Clock
    input wire reset, //Asynchronous system reset
    input wire [15:0]data_in, // Binary input vector
    output wire spi_cs_l, //Active Low chip select
    output wire spi_sclk,// SPI Bus Clock
    output wire spi_data, //SPI Bus Data
    output wire [4:0]counter
    );
    
    reg MOSI;
    reg [4:0]count;
    reg sclk;
    reg [1:0]state;
    reg cs_l;
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset)
        begin
            MOSI <= 1'b0;
            count <= 5'b10000;
            cs_l <= 1'b1;
            sclk <= 1'b0;
        end
        
        else 
        begin
            case(state)
                2'b00: begin
                sclk <= 1'b0;
                cs_l <= 1'b1;
                state <= 1;
                end
                
                2'b01: begin
                sclk <= 1'b1;
                cs_l <= 1'b0;
                MOSI <= data_in[count-1];
                count <= count-1;
                state <=2;
                end
                
                2'b10: begin
                sclk <= 1'b1;
                if (count>0)
                    state <=1;
                else 
                begin
                    count <= 5'b10000;
                    state <= 0;
                end
                end
                
                default: state <=0;
            endcase
      end
      end
         
         assign spi_cs_l = cs_l;
         assign spi_sclk = sclk;
         assign spi_data = MOSI;
         assign counter = count;
         
endmodule
