module OUTPR(
input D7  , 
input I   ,
input T3  , 
input B2  ,
input CLK ,
input [7:0] OUTPR_in ,
output reg  FGO ,
output reg [7:0] OUTPR );

wire E ;
wire J ;
wire K ;

assign E = (D7 & I & T3) & B2 ;
assign J = ~E ;
assign K =  E ;

initial begin
OUTPR = 8'h00 ;
FGO   = 1'b0  ;
end

always @(posedge CLK )
begin 
// 8-Bit Register
if(E == 1)
     begin
  OUTPR <= OUTPR_in ;   // Load data
     end     
else
     begin 
 OUTPR <= OUTPR  ;      // Hold data
     end 
// FGO JK Flip Flop    
case({K,J})
   2'b00 : FGO <= FGO  ;  // NO change 
   2'b01 : FGO <= 1'b1 ;  // Set 
   2'b10 : FGO <= 1'b0 ;  // Reset 
   2'b11 : FGO <= ~FGO ;  // Toggle
endcase    
end

endmodule
