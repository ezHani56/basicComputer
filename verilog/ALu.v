`timescale 1ns / 1ps
module ALU(
input CLK ,
input D0  ,
input D1  ,
input D2  ,
input D5  ,
input D6  ,
input D7  ,
input B1  ,
input B2  ,
input B3  ,
input I   ,
input T3  ,
input T5  ,
input [7:0] DR    ,
input [7:0] INPR  ,
input [7:0] AC    ,
output reg [7:0] AC_in ,
output reg E    );

wire LDA  ;
wire AND  ;
wire ADD  ;
wire CMA  ;
wire INC  ;
wire OR   ;
wire INP  ;
wire clk  ;
reg  CO   ;
wire r    ;
wire p    ;

assign p   = I&D7&T3    ;
assign r   = ~I&D7&T3   ;
assign LDA = T5&(D2|D5) ;
assign AND = D0&T5 ;
assign ADD = D1&T5 ;
assign CMA = r&B2  ;
assign INC = r&B1  ;
assign OR  = D6&T5 ;
assign INP = p&B3  ;
assign clk = ADD & CLK ;

initial begin
CO = 0 ;
E  = 0 ;
end

always @(*) begin
if (LDA == 1)
   begin
AC_in <= DR  ;
   end
 else if (AND == 1)
   begin
AC_in <= DR & AC ;
   end
else if (ADD == 1) 
   begin
{CO , AC_in} <= DR + AC ;
   end
else if (CMA == 1)
   begin
AC_in <= ~AC ;
   end
else if (INC == 1)   
   begin
AC_in <= AC + 1 ;
   end
else if (OR == 1)
   begin
AC_in <= (DR | AC) ;
   end
else if (INP == 1)
   begin   
AC_in <= INPR ;
   end
else 
   begin
AC_in <= 8'hzz ;
   end   
end
always @(posedge clk )begin 
E <= CO ;
end

endmodule
