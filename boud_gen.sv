module boud_gen(clk,reset,tick);
  input clk,reset;
  output reg tick;
  reg [12:0]count;
  
  parameter CLK_PER_BIT = 5208;  // 50000000/9600
  always @ (posedge clk or posedge reset)
    begin
    if (reset)
      begin
        count <=0;
        tick<=0;
      end
      else begin
        if (count==CLK_PER_BIT-1)
          begin
            count <=0;
            tick<=1;
          end
        else begin
          count <=count+1;
          tick<=0;
        end
      end
      
      
      end
  endmodule 
