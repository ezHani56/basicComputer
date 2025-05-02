module SC(
input CLK ,
input R   ,
input D0  ,
input D1  ,
input D2  ,
input D3  ,
input D4  ,
input D5  ,
input D6  ,
input D7  ,
input B0  ,
input I   ,
output reg [7:0] SC ,
output  T0 ,
output  T1 ,
output  T2 ,
output  T3 ,
output  T4 ,
output  T5 ,
output  T6 ,
output  T7      );

wire CLR ;
wire HLT ;
reg [2:0] state ;

assign CLR = ~((R&T2)|((D0|D1|D2|D6)&T5)|((D3|D4)&T4)|(D5&T6));
assign HLT = ~(B0&D7&T3&!I) ;
assign T0 = SC[0] ;
assign T1 = SC[1] ;
assign T2 = SC[2] ;
assign T3 = SC[3] ;
assign T4 = SC[4] ;
assign T5 = SC[5] ;
assign T6 = SC[6] ;
assign T7 = SC[7] ;

initial begin 
state = 3'b000 ;
end

always @(posedge CLK or negedge HLT) begin
  if (CLR == 0)begin
state <= 3'b000 ;        // to make SC start from the begining
  end
  else if (!HLT)begin
state <= state ;        // to make SC stop counting
  end 
     else begin
state <= (state == 3'b111) ? 3'b000 : state + 1;     // to make SC count 
     end
end
// Decoder 3x8 
always @(*) begin
  case(state)
3'b000  : SC = 8'h01  ;
3'b001  : SC = 8'h02  ;
3'b010  : SC = 8'h04  ;
3'b011  : SC = 8'h08  ;
3'b100  : SC = 8'h10  ;
3'b101  : SC = 8'h20  ;
3'b110  : SC = 8'h40  ;
3'b111  : SC = 8'h80  ;
default : SC = 8'h01  ;
  endcase
end

endmodule
