module RU(
input CLK  ,
input B0   ,
input B1   ,
input T3   ,
input T2   ,
input T1   ,
input T0   ,
input D7   ,
input I    ,
input FGI  ,
input FGO  ,
output reg R     );

reg IEN ;
wire P  ;
wire J1 ;
wire K1 ;
wire J2 ;
wire K2 ;

initial begin
IEN <= 0 ;
R   <= 0 ;
end

assign P = T3&I&D7 ;
assign J1 = B1&P ;
assign K1 = B0&P ;
assign J2 = (FGI|FGO)&IEN&~(T0|T1|T2);
assign K2 = T2&R ;

always @(posedge CLK) begin      
  // JK flip-flop_1 
case ({J1, K1}) 
   2'b00: IEN <= IEN  ;        // No change (K = 0 ,J = 0)     
   2'b01: IEN <= 1'b0 ;        // Reset (K = 1, J = 0) 
   2'b10: IEN <= 1'b1;         // Set (K = 0, J = 1)
   2'b11: IEN <= ~IEN;         // Toggle (K = 1, J = 1)
endcase
 // JK flip-flop_2 
case({J2, K2})
   2'b00: R <= R;                    // No change (K = 0 ,J = 0) 
   2'b01: R <= 1'b0;                 // Reset (K = 1, J = 0)
   2'b10: R <= 1'b1;                 // Set (K = 0, J = 1)
   2'b11: R <= ~IEN;                 // Toggle (K = 1, J = 1)
endcase
end

endmodule
