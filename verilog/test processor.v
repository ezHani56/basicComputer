module PR_tb ;
reg CLK  = 0     ;   
reg [7:0] INPR   ;
wire R           ;
wire FGI         ;
wire FGO         ;
wire E           ;
wire [7:0] SC    ;
wire [7:0] MEM   ;
wire [3:0] AR    ;
wire [3:0] PC    ;
wire [7:0] IR    ;
wire [7:0] DR    ;
wire [7:0] AC    ;
wire [7:0] OUTPR ;
wire [7:0] TR    ;

// instantiate Processor (top module)
Processor Pr (
.CLK   (CLK   ) ,
.INPR  (INPR  ) ,
.R     (R     ) ,
.FGI   (FGI   ) ,
.FGO   (FGO   ) ,
.E     (E     ) ,
.SC    (SC    ) ,  
.MEM   (MEM   ) ,
.AR    (AR    ) ,
.PC    (PC    ) ,
.IR    (IR    ) ,
.DR    (DR    ) ,
.AC    (AC    ) ,
.OUTPR (OUTPR ) ,
.TR    (TR    ) 

);

always #0.2 CLK = ~CLK ;

initial 
  begin 
  
INPR = 8'h77 ; #5  ;
INPR = 8'h11 ; #20 ;

  end

endmodule
