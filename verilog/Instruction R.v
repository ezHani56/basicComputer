module IR(
input  R    ,
input  T1   ,
input  CLK  ,
input  [7:0] IR_in   ,
output reg [7:0] IR  ,
output  B0 ,
output  B1 ,
output  B2 ,
output  B3 ,
output  I  ,
output  D0 ,
output  D1 ,
output  D2 ,
output  D3 ,
output  D4 ,
output  D5 ,
output  D6 ,
output  D7     );

wire A ;
wire B ;
wire C ;
wire E ;
reg [7:0] DEC_out ;

assign E  = ~R & T1 ;

assign B0 = IR[0]  ;
assign B1 = IR[1]  ;
assign B2 = IR[2]  ;
assign B3 = IR[3]  ;
assign A  = IR[4]  ;
assign B  = IR[5]  ;
assign C  = IR[6]  ;
assign I  = IR[7]  ;

assign D0 = DEC_out[0]  ;
assign D1 = DEC_out[1]  ;
assign D2 = DEC_out[2]  ;
assign D3 = DEC_out[3]  ;
assign D4 = DEC_out[4]  ; 
assign D5 = DEC_out[5]  ;
assign D6 = DEC_out[6]  ;
assign D7 = DEC_out[7]  ;

initial begin 
 IR = 8'h00 ;
end

always @(posedge CLK )
begin
if (E == 1)
     begin
 IR <=  IR_in  ;  // Load Data
     end 
else 
     begin
 IR <= IR     ;  // Hold Data
     end 
end

always @(*) begin
 // Decoder 3X8 to Decode op_code
 case({C,B,A}) 
   3'b000  : DEC_out = 8'b00000001  ;
   3'b001  : DEC_out = 8'b00000010  ;
   3'b010  : DEC_out = 8'b00000100  ;
   3'b011  : DEC_out = 8'b00001000  ;
   3'b100  : DEC_out = 8'b00010000  ;
   3'b101  : DEC_out = 8'b00100000  ;
   3'b110  : DEC_out = 8'b01000000  ;
   3'b111  : DEC_out = 8'b10000000  ;
   default : DEC_out = 8'b00000001  ;
 endcase   
end

endmodule
