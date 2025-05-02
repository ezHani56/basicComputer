`timescale 1ns / 1ps
module DR(
input D0  , 
input D1  ,
input D2  ,
input D5  , 
input D6  ,
input T4  ,
input T6  , 
input CLK ,
input [7:0] DR_in ,
output reg [7:0] DR    );

wire E ;
assign E  = ((D0|D1|D2|D6)& T4)|(D5&T6);

initial begin
  DR = 8'h00 ;
end

always @(posedge CLK )
begin
if (E == 1)
     begin
DR <= DR_in  ;  // Load Data
     end 
else 
     begin 
DR <= DR     ;  // Hold Data    
     end          
end

endmodule
