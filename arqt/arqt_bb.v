
module arqt (
	clk_clk,
	entrada_export,
	lcd_0_conduit_end_writeresponsevalid_n,
	lcd_0_conduit_end_1_writeresponsevalid_n,
	lcd_0_conduit_end_2_readdata,
	lcd_0_conduit_end_3_writeresponsevalid_n,
	saida_export);	

	input		clk_clk;
	input	[3:0]	entrada_export;
	output		lcd_0_conduit_end_writeresponsevalid_n;
	output		lcd_0_conduit_end_1_writeresponsevalid_n;
	output	[7:0]	lcd_0_conduit_end_2_readdata;
	output		lcd_0_conduit_end_3_writeresponsevalid_n;
	output	[3:0]	saida_export;
endmodule
