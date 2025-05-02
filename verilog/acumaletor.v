module AC(
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
input CLK ,
input [7:0] AC_in ,
output reg [7:0] AC    );

wire MR  ;
wire E   ;
wire LDA ;
wire AND ;
wire ADD ;
wire CMA ;
wire INC ;
wire OR  ;
wire INP ;
wire r   ;
wire p   ;

assign p   = I&D7&T3    ;
assign r   = ~I&D7&T3   ;
assign LDA = T5&(D2|D5) ;
assign AND = D0&T5 ;
assign ADD = D1&T5 ;
assign CMA = r&B2  ;
assign INC = r&B1  ;
assign OR  = D6&T5 ;
assign INP = p&B3  ;
assign MR  = (r & B3) ;
assign E   = (LDA | AND | ADD | CMA | INC | OR | INP) ;

initial begin
AC = 8'h00 ;
end

always @(posedge CLK or posedge MR)
begin
if (MR == 1)
  begin
AC <= 8'h00;        // Clear Data
  end
else if (E == 1 )
  begin
AC <= AC_in;       // Load Data
  end
else 
  begin 
AC <= AC ;        // Hold Data
  end 
end

endmodule
