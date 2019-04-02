
module arqt1 (
	clk_clk,
	int1_export,
	out1_export,
	lcd_0_conduit_end_writeresponsevalid_n,
	lcd_0_conduit_end_1_writeresponsevalid_n,
	lcd_0_conduit_end_2_readdata,
	lcd_0_conduit_end_3_writeresponsevalid_n);	

	input		clk_clk;
	input	[3:0]	int1_export;
	output	[3:0]	out1_export;
	output		lcd_0_conduit_end_writeresponsevalid_n;
	output		lcd_0_conduit_end_1_writeresponsevalid_n;
	output	[7:0]	lcd_0_conduit_end_2_readdata;
	output		lcd_0_conduit_end_3_writeresponsevalid_n;
endmodule
