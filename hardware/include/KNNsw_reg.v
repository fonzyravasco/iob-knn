//START_TABLE sw_reg

`SWREG_W(KNN_RESET, 1, 0) //KNN soft reset
`SWREG_W(KNN_ENABLE, 1, 0) //KNN enable :o

`SWREG_W(KNN_x1sw, `DATA_W/2, 0) //KNN componente x do primeiro ponto 
`SWREG_W(KNN_x2sw, `DATA_W/2, 0) //KNN componente x do segundo ponto
`SWREG_W(KNN_y1sw, `DATA_W/2, 0) //KNN componente y do primeiro ponto 
`SWREG_W(KNN_y2sw, `DATA_W/2, 0) //KNN componente y do segundo ponto 
`SWREG_R(KNN_zsw, `DATA_W, 0)

//`SWREG_BANKW(KNN_swdist,`DATA_W,0,2000) //KNN disntância a avaliar
//`SWREG_BANKR(KNN_output_vizinho, `DATA_W,0,200) //KNN output que sai do vizinho


