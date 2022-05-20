//reg [5:0] arr [0:9] - 10개의 array가 6개존재

module line_buffer (
  input wire clk,
  input wire rd,
  input wire wr,
  input wire en,  
  input wire rst,
  input wire data_in, //1bit input
  
  output wire empty,
  output wire full,
  output reg data_out  //1bit output
);

reg [3:0] count = 0 ; 
reg [13:0] fifo; //14bit fifo - line buffer

reg [3:0] readcounter, writecounter = 0 ;

assign empty = (count==0)? 1'b1:1'b0; 
assign full = (count==14)? 1'b1:1'b0; 
//14bit 채워지면 full, 없으면 empty

always @ (posedge clk)
begin
  if(en == 1'b1)
  begin
    if(rst) begin
      readcounter = 0;
      writecounter = 0;
    end
    
    //write - push
    else if (wr==1'b1 && count < 14) begin
      fifo[writecounter] <= data_in;
      writecounter = writecounter+1 ;
    end 
    //read - out
    else if (rd==1'b1 && count !=0) begin
      data_out <= fifo[readcounter];
      readcounter = readcounter + 1;
    end

  end

  if(readcounter > writecounter) 
  count = readcounter - writecounter;
  
  else if(readcounter < writecounter) 
  count = writecounter - readcounter;  

end

endmodule  









endmodule