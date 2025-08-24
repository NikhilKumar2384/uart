module uart_tx (tx,clk,tx_data,tx_busy,reset,tx_start,tick);
  input clk,tx_start,reset;
  input reg [7:0]tx_data;
  output reg tx,tx_busy;
  reg [3:0]index;
  reg [9:0]tx_shift;
  input logic tick;
  
  
  
  
  
  
  typedef enum logic[0:0]{
 idle = 1'b0,
 trans= 1'b1
  }state_t;
  
  state_t state = idle;

  always @(posedge clk or posedge reset)
    begin 
      if (reset) begin 
      tx_busy<=0;
        tx<=1'b1;
        index<=0;
        state<=idle;
      end
      else begin
        case (state)
         
            idle : begin
              
              tx<=1'b1;
              index<=0;
              tx_busy<=0;
              if (tx_start)begin 
                tx_busy<=1;
                tx_shift ={1'b1,tx_data,1'b0};
                state <=trans;
              end
            end
            trans: begin 
              if (tick)begin 
                tx<=tx_shift[index];
              index<=index+1;
              end
              if (index==10) begin state <= idle;
                tx_busy <=0;
              end;
              
            end
            
        endcase
          end
     
    end
  
endmodule 
