module Processor(
input  CLK         ,
input  [7:0] INPR  ,
output R   , 
output FGI ,
output FGO ,
output E   ,
output [7:0] SC    ,
output [7:0] MEM   ,
output [3:0] AR    ,
output [3:0] PC    ,
output [7:0] IR    ,
output [7:0] DR    ,
output [7:0] AC    ,
output [7:0] OUTPR ,
output [7:0] TR          );


wire wire_r   ;
wire wire_e   ;
wire wire_fgi ;
wire wire_fgo ;
wire wire_d0  ;
wire wire_d1  ;
wire wire_d2  ;
wire wire_d3  ;
wire wire_d4  ;
wire wire_d5  ;
wire wire_d6  ;
wire wire_d7  ;
wire wire_b0  ;
wire wire_b1  ;
wire wire_b2  ;
wire wire_b3  ;
wire wire_i   ;
wire wire_t0  ;
wire wire_t1  ;
wire wire_t2  ;
wire wire_t3  ;
wire wire_t4  ;
wire wire_t5  ;
wire wire_t6  ;
wire wire_t7  ;
wire [7:0] wire_cb    ;
wire [7:0] wire_ac_in ;
wire [7:0] wire_ac    ;
wire [7:0] wire_mem   ;
wire [3:0] wire_ar    ;
wire [3:0] wire_pc    ;
wire [7:0] wire_dr    ;
wire [7:0] wire_ir    ;
wire [7:0] wire_tr    ;
wire [7:0] wire_inpr  ;

assign R   = wire_r   ;
assign AC  = wire_ac  ;
assign PC  = wire_pc  ;
assign AR  = wire_ar  ;
assign IR  = wire_ir  ;
assign TR  = wire_tr  ;
assign DR  = wire_dr  ;
assign MEM = wire_mem ;
assign FGI = wire_fgi ;
assign FGO = wire_fgo ;
assign E   = wire_e   ;


//instantiate SC 
SC sc (
.CLK (  CLK   ) ,
.R   (wire_r  ) ,
.D0  (wire_d0 ) ,
.D1  (wire_d1 ) ,
.D2  (wire_d2 ) ,
.D3  (wire_d3 ) ,
.D4  (wire_d4 ) ,
.D5  (wire_d5 ) ,
.D6  (wire_d6 ) ,
.D7  (wire_d7 ) ,
.B0  (wire_b0 ) ,
.I   (wire_i  ) ,
.T0  (wire_t0 ) ,
.T1  (wire_t1 ) ,
.T2  (wire_t2 ) ,
.T3  (wire_t3 ) ,
.T4  (wire_t4 ) ,
.T5  (wire_t5 ) ,
.T6  (wire_t6 ) ,
.T7  (wire_t7 ) , 
.SC  (   SC   ) 

);

//instantiate IR
IR ir (
.CLK  (  CLK  ) ,
.R    (wire_r ) ,
.T1   (wire_t1) ,
.IR_in(wire_cb) ,
.IR   (wire_ir) ,
.B0   (wire_b0) ,
.B1   (wire_b1) ,
.B2   (wire_b2) ,
.B3   (wire_b3) ,
.I    (wire_i ) ,
.D0   (wire_d0) ,
.D1   (wire_d1) ,
.D2   (wire_d2) ,
.D3   (wire_d3) ,
.D4   (wire_d4) ,
.D5   (wire_d5) ,
.D6   (wire_d6) ,
.D7   (wire_d7) 

);

//instantiate RU
RU ru (
.CLK (  CLK   ) ,
.B0  (wire_b0 ) ,
.B1  (wire_b1 ) ,
.T3  (wire_t3 ) ,
.T2  (wire_t2 ) ,
.T1  (wire_t1 ) ,
.T0  (wire_t0 ) ,
.D7  (wire_d7 ) ,
.I   (wire_i  ) ,
.FGI (wire_fgi) ,
.FGO (wire_fgo) ,
.R   (wire_r  ) 

);

//instantiate Bus_Selector
Bus_Selector bs(
.R    (wire_r  ) ,
.T0   (wire_t0 ) ,
.T1   (wire_t1 ) ,
.T2   (wire_t2 ) ,
.T3   (wire_t3 ) ,
.T4   (wire_t4 ) ,
.T6   (wire_t6 ) ,
.D0   (wire_d0 ) ,
.D1   (wire_d1 ) ,
.D2   (wire_d2 ) ,
.D3   (wire_d3 ) ,
.D4   (wire_d4 ) ,
.D5   (wire_d5 ) ,
.D6   (wire_d6 ) ,
.D7   (wire_d7 ) ,
.B2   (wire_b2 ) ,
.I    (wire_i  ) ,
.AR   (wire_ar ) ,
.PC   (wire_pc ) ,
.AC   (wire_ac ) ,
.IR   (wire_ir ) ,
.TR   (wire_tr ) ,
.MEM_O(wire_mem) ,
.CB   (wire_cb ) 

);

//instantiate MEM 
MEM mem (
.address  (wire_ar ) ,
.MEM_in   (wire_cb ) ,
.R        (wire_r  ) ,
.T1       (wire_t1 ) ,
.T4       (wire_t4 ) ,
.D3       (wire_d3 ) ,
.D5       (wire_d5 ) ,
.MEM_out  (wire_mem) 

);

//instantiate AR
AR ar (
.CLK   (  CLK  ),
.D7    (wire_d7),
.I     (wire_i ),
.R     (wire_r ),
.T0    (wire_t0),
.T2    (wire_t2),
.T3    (wire_t3),
.AR_in (wire_cb),
.AR    (wire_ar)

);

//instantiate PC
PC pc (
.CLK   (  CLK  ) ,
.T1    (wire_t1) ,
.T2    (wire_t2) ,
.T4    (wire_t4) ,
.D4    (wire_d4) ,
.R     (wire_r ) ,
.PC_in (wire_cb) ,
.PC    (wire_pc) 

);

// instantiate DR 
DR dr (
.CLK   (  CLK  ) ,
.D0    (wire_d0) ,
.D1    (wire_d1) ,
.D2    (wire_d2) ,
.D5    (wire_d5) ,
.D6    (wire_d6) ,
.T4    (wire_t4) ,
.T6    (wire_t6) ,
.DR_in (wire_cb) ,
.DR    (wire_dr) 

);

// instantiate ALU
ALU alu (
.CLK   (   CLK    ) ,
.D0    (wire_d0   ) ,
.D1    (wire_d1   ) ,
.D2    (wire_d2   ) ,
.D5    (wire_d5   ) ,
.D6    (wire_d6   ) ,
.D7    (wire_d7   ) ,
.B1    (wire_b1   ) ,
.B2    (wire_b2   ) ,
.B3    (wire_b3   ) ,
.I     (wire_i    ) ,
.T3    (wire_t3   ) ,
.T5    (wire_t5   ) ,
.DR    (wire_dr   ) ,
.INPR  (wire_inpr ) ,
.AC    (wire_ac   ) ,
.AC_in (wire_ac_in) ,
.E     (wire_e    ) 

);

//instantiate AC
AC ac (
.CLK  (    CLK   ) ,
.D0   (wire_d0   ) ,
.D1   (wire_d1   ) ,
.D2   (wire_d2   ) ,
.D5   (wire_d5   ) ,
.D6   (wire_d6   ) ,
.D7   (wire_d7   ) ,
.B1   (wire_b1   ) ,
.B2   (wire_b2   ) ,
.B3   (wire_b3   ) ,
.I    (wire_i    ) ,
.T3   (wire_t3   ) ,
.T5   (wire_t5   ) ,
.AC_in(wire_ac_in) ,
.AC   (wire_ac   ) 

);

//instantiate INPR
INPR inpr (
.CLK      (   CLK   ) ,
.D7       (wire_d7  ) ,
.I        (wire_i   ) ,
.T3       (wire_t3  ) ,
.B3       (wire_b3  ) ,
.INPR_in  (INPR     ) ,
.FGI      (wire_fgi ) ,
.INPR_out (wire_inpr) 

);

//instantiate OUTPR
OUTPR outpr (
.CLK      (  CLK   ) ,
.D7       (wire_d7 ) ,
.I        (wire_i  ) ,
.T3       (wire_t3 ) ,
.B2       (wire_b2 ) ,
.OUTPR_in (wire_cb ) ,
.FGO      (wire_fgo) ,
.OUTPR    (OUTPR   ) 

);

//instantiate TR
TR tr (
.CLK   (  CLK  ) ,
.R     (wire_r ) ,
.T0    (wire_t0) ,
.TR_in (wire_cb) ,
.TR    (wire_tr) 

);

endmodule
