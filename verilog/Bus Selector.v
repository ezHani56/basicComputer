module Bus_Selector(
input R  ,
input T0 ,
input T1 ,
input T2 ,
input T3 ,
input T4 ,
input T6 ,
input D0 ,
input D1 ,
input D2 ,
input D3 ,
input D4 ,
input D5 ,
input D6 ,
input D7 ,
input B2 ,
input I  ,
input [3:0] AR ,
input [3:0] PC ,
input [7:0] AC ,
input [7:0] IR ,
input [7:0] TR ,
input [7:0] MEM_O ,
output reg [7:0] CB );

wire AR_R    ;
wire PC_R    ;
wire AC_R    ;
wire IR_R    ;
wire TR_R    ;
wire MEM_R   ;
reg  [2:0] S ;
wire [5:0] X ;

assign AR_R = D4&T4 ;
assign PC_R = ~R&T0 ;
assign AC_R = (D5&T4)|(D3&T4)|(I&D7&T3&B2) ;
assign IR_R = ~R&T2 ;
assign TR_R =  R&T1 ;
assign MEM_R = (~R&T1)|(~D7&I&T3)|(T4&(D0|D1|D2|D6))|(D6&T6) ;
assign X = {MEM_R, TR_R, IR_R, AC_R, PC_R, AR_R } ;

always @(*) begin 
// Encoder
case(X)
 6'b000000 : S = 3'b000 ;
 6'b000001 : S = 3'b001 ;
 6'b000010 : S = 3'b010 ;
 6'b000100 : S = 3'b011 ;
 6'b001000 : S = 3'b100 ;
 6'b010000 : S = 3'b101 ;
 6'b100000 : S = 3'b110 ;
 default   : S = 3'b000 ;
endcase
// MUX
case(S)
 3'b000  : CB = 8'hzz ;
 3'b001  : CB = {4'b0000,AR} ;
 3'b010  : CB = {4'b0000,PC} ;
 3'b011  : CB = AC ;
 3'b100  : CB = IR ;
 3'b101  : CB = TR ;
 3'b110  : CB = MEM_O ;
 default : CB = 8'hzz ;
endcase
end

endmodule
