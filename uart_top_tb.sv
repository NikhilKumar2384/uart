module uart_top_tb;
  reg clk=0;
  reg tx_start,rx;
  reg reset =1;
  wire tx_line,tx_busy,rx_valid;
  wire [7:0]rx_data;
  reg [7:0]tx_data;
  
  parameter CLK_PER_BIT=10;
  parameter CLK_PERIOD=20;
  
  uart_top#(
    .CLK_PER_BIT(CLK_PER_BIT))
  dut ( .clk(clk),
   .reset(reset),
   .send(tx_start),
   .data_in(tx_data),
       .rx(tx),      // CONNECTING TX TERMINAL TO RX
   .data_out(rx_data),
   .tx(tx),
   .data_ready(rx_valid),
   .tx_busy(tx_busy)
    );
 
  
  
  always #(CLK_PERIOD/2) clk=~clk;
  
  initial begin
    $display ("start");
    $dumpfile("boud_top_tb.vcd");
    $dumpvars(0,uart_top_tb);
     #23
    #20
    reset=0;
    
   
    #30 
    tx_start <=1;
    tx_data<= 8'b10111001;
    #20
    tx_start <=0; // transmittor test case
    
    
   #4000
   tx_start<=1;
   tx_data<=8'b11001001;
   #20
   tx_start<=0;// transmittor test case 
    
  #4000
    
     tx_start<=1;
   tx_data<=8'b00011101;
   #20
   tx_start<=0;  // transmittor test case
    #4000
    tx_start<=1;
   tx_data<=8'b00011100;
   #20
   tx_start<=0;  // transmittor test case
  
   #4000
    $display ("finish");
    $finish;
  end
endmodule
