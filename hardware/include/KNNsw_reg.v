//START_TABLE sw_reg

`SWREG_W(KNN_RESET, 1, 0) //KNN soft reset
`SWREG_W(KNN_ENABLE, 1, 0) //KNN enable :o

`SWREG_W(KNN_x1sw, `DATA_W/2, 0)
`SWREG_W(KNN_x2sw, `DATA_W/2, 0)
`SWREG_W(KNN_y1sw, `DATA_W/2, 0)
`SWREG_W(KNN_y2sw, `DATA_W/2, 0)
`SWREG_W(KNN_zsw, `DATA_W, 0)



