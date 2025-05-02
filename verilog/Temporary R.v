module TR(
input R    ,
input T0   ,
input CLK  ,
input [7:0] TR_in  ,
output reg [7:0] TR   );

wire E ;
assign E  = R & T0 ;

initial begin 
TR = 8'h00 ;
end

always @(posedge CLK )
begin
if (E == 1)
     begin
 TR <=  TR_in  ;  // Load Data
     end 
else 
     begin
 TR <= TR     ;  // Hold Data
     end 
end

endmodule
