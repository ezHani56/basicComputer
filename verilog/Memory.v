`timescale 1ns / 1ps
module MEM ( 
  // our memory is 16x8 SRAM Type 
 input [3:0] address ,   
 input [7:0] MEM_in  ,  
 input R  ,
 input T1 ,
 input T4 ,
 input D3 ,
 input D5 ,   
 output reg [7:0] MEM_out  
);

wire WR ;
assign WR = ~(R&T1|D3&T4|D5&T4)   ;    // control signal for Ram
reg [7:0] memory_locations [15:0] ;   // 16 location , each 8 bit

 //$readmemh("C:/RAM_data.txt",memory_locations);  // to load data from file in my pc

 initial begin 
 // to initial store instructions or data in Ram befor simulation 
 memory_locations[0]  = 8'hf8 ;  // location 0
 memory_locations[1]  = 8'h3f ;  // location 1
 memory_locations[2]  = 8'hf8 ;  // location 2
 memory_locations[3]  = 8'h1f ;  // location 3
 memory_locations[4]  = 8'hf4 ;  // location 4
 memory_locations[5]  = 8'h71 ;  // location 5
 memory_locations[6]  = 8'h00 ;  // location 6
 memory_locations[7]  = 8'h00 ;  // location 7
 memory_locations[8]  = 8'h00 ;  // location 8
 memory_locations[9]  = 8'h00 ;  // location 9
 memory_locations[10] = 8'h00 ;  // location 10
 memory_locations[11] = 8'h00 ;  // location 11
 memory_locations[12] = 8'h00 ;  // location 12
 memory_locations[13] = 8'h00 ;  // location 13
 memory_locations[14] = 8'h00 ;  // location 14
 memory_locations[15] = 8'h00 ;  // location 15
 end

always @(*) begin
if (WR == 0)
    begin
memory_locations[address] <= MEM_in  ;     // Write operation
MEM_out <= 8'hzz ;
    end
else 
    begin
MEM_out <=  memory_locations[address] ;   // Read operation
    end
end

endmodule
