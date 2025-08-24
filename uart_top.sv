 `include "boud_gen.v"
`include "tx_uart.v"
`include "rx_uart.v"

module uart_top(clk,reset,send,data_in,rx,data_out,tx,data_ready,tx_busy);
input clk,reset;
input send,rx;
input [7:0] data_in;
output tx,tx_busy,data_ready;
output[7:0]data_out;
logic tick;
  
   parameter CLK_PER_BIT=5208;
  
  
  boud_gen #(
    .CLK_PER_BIT(CLK_PER_BIT)
  ) boud_gen1 (.clk(clk),
               .reset(reset),
               .tick(tick)
  );
  
  uart_tx uart_tx1(.clk(clk),
                   .reset(reset),
                   .tx_data(data_in),
                   .tx(tx),
                   .tick(tick),
                   .tx_start(send),
                   .tx_busy(tx_busy));
  
  
  uart_rx  #(
    .CLK_PER_BIT(CLK_PER_BIT) )uart_rx1(
    .clk(clk),
    .reset(reset),
    .tick(tick),
    .rx(rx),
    .rx_data(data_out),
    .rx_valid(data_ready));
  
endmodule
  
