	component arqte1 is
		port (
			clk_clk                                  : in  std_logic                    := 'X';             -- clk
			int1_export                              : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			lcd_0_conduit_end_writeresponsevalid_n   : out std_logic;                                       -- writeresponsevalid_n
			lcd_0_conduit_end_1_writeresponsevalid_n : out std_logic;                                       -- writeresponsevalid_n
			lcd_0_conduit_end_2_readdata             : out std_logic_vector(7 downto 0);                    -- readdata
			lcd_0_conduit_end_3_writeresponsevalid_n : out std_logic;                                       -- writeresponsevalid_n
			out1_export                              : out std_logic_vector(3 downto 0)                     -- export
		);
	end component arqte1;

	u0 : component arqte1
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                 clk.clk
			int1_export                              => CONNECTED_TO_int1_export,                              --                int1.export
			lcd_0_conduit_end_writeresponsevalid_n   => CONNECTED_TO_lcd_0_conduit_end_writeresponsevalid_n,   --   lcd_0_conduit_end.writeresponsevalid_n
			lcd_0_conduit_end_1_writeresponsevalid_n => CONNECTED_TO_lcd_0_conduit_end_1_writeresponsevalid_n, -- lcd_0_conduit_end_1.writeresponsevalid_n
			lcd_0_conduit_end_2_readdata             => CONNECTED_TO_lcd_0_conduit_end_2_readdata,             -- lcd_0_conduit_end_2.readdata
			lcd_0_conduit_end_3_writeresponsevalid_n => CONNECTED_TO_lcd_0_conduit_end_3_writeresponsevalid_n, -- lcd_0_conduit_end_3.writeresponsevalid_n
			out1_export                              => CONNECTED_TO_out1_export                               --                out1.export
		);

