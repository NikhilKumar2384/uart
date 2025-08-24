module uart_rx(clk,reset,rx,rx_valid,rx_data,tick);
  input clk,rx,reset;
  output reg rx_valid;
  output reg [7:0]rx_data;
  input logic tick;
 parameter CLK_PER_BIT=5208; 
 
  
 
  
  
  typedef enum logic[1:0] {
    idle   = 2'b00,
    start  = 2'b01,
    receive = 2'b10,
    stop   = 2'b11
  } state_t;

  state_t state = idle;
  
  

  reg [3:0] index;
  reg [31:0] tick_count;
  reg [8:0] shift_reg;

  
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state      <= idle;
      rx_valid   <= 0;
      rx_data    <= 0;
      index      <= 0;
      tick_count <= 0;
    end else begin
      rx_valid <= 0;  

      case (state)
        idle: begin
//           if (tick ) begin 
            if(rx==0) begin
            tick_count <= 0;
            state <= start;
//             end
          end
        end

        start: begin
          if (clk) begin
            tick_count <= tick_count + 1;
            if (tick_count ==( CLK_PER_BIT/2)) begin
              if (rx == 0) begin
                state <= receive;
                tick_count <= 0;
              index <= 0;
                          end 
              else   begin
                state <= idle;
                     end
            end
          end
        end

        receive: begin
          if (tick) begin
            shift_reg[index] <= rx;
//             tick_count <= tick_count + 1;
            if (index<9) begin
//               tick_count <= 0;
              index <= index + 1;
              if (index == 8) begin
                state <= stop;
                              end
                                  end
          end
        end

        stop: begin
          if (tick) begin
            if (rx == 1) begin  
              rx_data <= shift_reg[8:1];
              rx_valid <= 1;
                          end
            state <= idle;
                     end
              end
      endcase
    end
  end

endmodule


 
