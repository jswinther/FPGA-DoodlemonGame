--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
--Date        : Fri Jan 18 14:45:11 2019
--Host        : NicoLenovo running 64-bit major release  (build 9200)
--Command     : generate_target hdmi_in_wrapper.bd
--Design      : hdmi_in_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi_in_wrapper is
  port (
    BCLK_0 : out STD_LOGIC;
    DDC_scl_io : inout STD_LOGIC;
    DDC_sda_io : inout STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FCLK_CLK3_0 : out STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    GPIO_0_tri_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
    IIC_0_scl_io : inout STD_LOGIC;
    IIC_0_sda_io : inout STD_LOGIC;
    IIC_1_0_scl_io : inout STD_LOGIC;
    IIC_1_0_sda_io : inout STD_LOGIC;
    PBDATA_0 : out STD_LOGIC;
    PBLRCLK_0 : out STD_LOGIC;
    RECDAT_0 : in STD_LOGIC;
    RECLRCLK_0 : out STD_LOGIC;
    TMDS_clk_n : in STD_LOGIC;
    TMDS_clk_p : in STD_LOGIC;
    TMDS_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    btns_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    hdmi_hpd_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    leds_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sws_4bits_0_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sws_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC
  );
end hdmi_in_wrapper;

architecture STRUCTURE of hdmi_in_wrapper is
  component hdmi_in is
  port (
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC;
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    leds_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sws_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IIC_0_sda_i : in STD_LOGIC;
    IIC_0_sda_o : out STD_LOGIC;
    IIC_0_sda_t : out STD_LOGIC;
    IIC_0_scl_i : in STD_LOGIC;
    IIC_0_scl_o : out STD_LOGIC;
    IIC_0_scl_t : out STD_LOGIC;
    btns_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    DDC_scl_i : in STD_LOGIC;
    DDC_scl_o : out STD_LOGIC;
    DDC_scl_t : out STD_LOGIC;
    DDC_sda_i : in STD_LOGIC;
    DDC_sda_o : out STD_LOGIC;
    DDC_sda_t : out STD_LOGIC;
    TMDS_clk_p : in STD_LOGIC;
    TMDS_clk_n : in STD_LOGIC;
    TMDS_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_hpd_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    BCLK_0 : out STD_LOGIC;
    PBLRCLK_0 : out STD_LOGIC;
    RECLRCLK_0 : out STD_LOGIC;
    PBDATA_0 : out STD_LOGIC;
    RECDAT_0 : in STD_LOGIC;
    IIC_1_0_sda_i : in STD_LOGIC;
    IIC_1_0_sda_o : out STD_LOGIC;
    IIC_1_0_sda_t : out STD_LOGIC;
    IIC_1_0_scl_i : in STD_LOGIC;
    IIC_1_0_scl_o : out STD_LOGIC;
    IIC_1_0_scl_t : out STD_LOGIC;
    FCLK_CLK3_0 : out STD_LOGIC;
    sws_4bits_0_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GPIO_0_tri_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    GPIO_0_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    GPIO_0_tri_t : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component hdmi_in;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal DDC_scl_i : STD_LOGIC;
  signal DDC_scl_o : STD_LOGIC;
  signal DDC_scl_t : STD_LOGIC;
  signal DDC_sda_i : STD_LOGIC;
  signal DDC_sda_o : STD_LOGIC;
  signal DDC_sda_t : STD_LOGIC;
  signal GPIO_0_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal GPIO_0_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal GPIO_0_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal GPIO_0_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal IIC_0_scl_i : STD_LOGIC;
  signal IIC_0_scl_o : STD_LOGIC;
  signal IIC_0_scl_t : STD_LOGIC;
  signal IIC_0_sda_i : STD_LOGIC;
  signal IIC_0_sda_o : STD_LOGIC;
  signal IIC_0_sda_t : STD_LOGIC;
  signal IIC_1_0_scl_i : STD_LOGIC;
  signal IIC_1_0_scl_o : STD_LOGIC;
  signal IIC_1_0_scl_t : STD_LOGIC;
  signal IIC_1_0_sda_i : STD_LOGIC;
  signal IIC_1_0_sda_o : STD_LOGIC;
  signal IIC_1_0_sda_t : STD_LOGIC;
begin
DDC_scl_iobuf: component IOBUF
     port map (
      I => DDC_scl_o,
      IO => DDC_scl_io,
      O => DDC_scl_i,
      T => DDC_scl_t
    );
DDC_sda_iobuf: component IOBUF
     port map (
      I => DDC_sda_o,
      IO => DDC_sda_io,
      O => DDC_sda_i,
      T => DDC_sda_t
    );
GPIO_0_tri_iobuf_0: component IOBUF
     port map (
      I => GPIO_0_tri_o_0(0),
      IO => GPIO_0_tri_io(0),
      O => GPIO_0_tri_i_0(0),
      T => GPIO_0_tri_t_0(0)
    );
IIC_0_scl_iobuf: component IOBUF
     port map (
      I => IIC_0_scl_o,
      IO => IIC_0_scl_io,
      O => IIC_0_scl_i,
      T => IIC_0_scl_t
    );
IIC_0_sda_iobuf: component IOBUF
     port map (
      I => IIC_0_sda_o,
      IO => IIC_0_sda_io,
      O => IIC_0_sda_i,
      T => IIC_0_sda_t
    );
IIC_1_0_scl_iobuf: component IOBUF
     port map (
      I => IIC_1_0_scl_o,
      IO => IIC_1_0_scl_io,
      O => IIC_1_0_scl_i,
      T => IIC_1_0_scl_t
    );
IIC_1_0_sda_iobuf: component IOBUF
     port map (
      I => IIC_1_0_sda_o,
      IO => IIC_1_0_sda_io,
      O => IIC_1_0_sda_i,
      T => IIC_1_0_sda_t
    );
hdmi_in_i: component hdmi_in
     port map (
      BCLK_0 => BCLK_0,
      DDC_scl_i => DDC_scl_i,
      DDC_scl_o => DDC_scl_o,
      DDC_scl_t => DDC_scl_t,
      DDC_sda_i => DDC_sda_i,
      DDC_sda_o => DDC_sda_o,
      DDC_sda_t => DDC_sda_t,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FCLK_CLK3_0 => FCLK_CLK3_0,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      GPIO_0_tri_i(0) => GPIO_0_tri_i_0(0),
      GPIO_0_tri_o(0) => GPIO_0_tri_o_0(0),
      GPIO_0_tri_t(0) => GPIO_0_tri_t_0(0),
      HDMI_OEN(0) => HDMI_OEN(0),
      IIC_0_scl_i => IIC_0_scl_i,
      IIC_0_scl_o => IIC_0_scl_o,
      IIC_0_scl_t => IIC_0_scl_t,
      IIC_0_sda_i => IIC_0_sda_i,
      IIC_0_sda_o => IIC_0_sda_o,
      IIC_0_sda_t => IIC_0_sda_t,
      IIC_1_0_scl_i => IIC_1_0_scl_i,
      IIC_1_0_scl_o => IIC_1_0_scl_o,
      IIC_1_0_scl_t => IIC_1_0_scl_t,
      IIC_1_0_sda_i => IIC_1_0_sda_i,
      IIC_1_0_sda_o => IIC_1_0_sda_o,
      IIC_1_0_sda_t => IIC_1_0_sda_t,
      PBDATA_0 => PBDATA_0,
      PBLRCLK_0 => PBLRCLK_0,
      RECDAT_0 => RECDAT_0,
      RECLRCLK_0 => RECLRCLK_0,
      TMDS_clk_n => TMDS_clk_n,
      TMDS_clk_p => TMDS_clk_p,
      TMDS_data_n(2 downto 0) => TMDS_data_n(2 downto 0),
      TMDS_data_p(2 downto 0) => TMDS_data_p(2 downto 0),
      btns_4bits_tri_i(3 downto 0) => btns_4bits_tri_i(3 downto 0),
      hdmi_hpd_tri_o(0) => hdmi_hpd_tri_o(0),
      leds_4bits_tri_o(3 downto 0) => leds_4bits_tri_o(3 downto 0),
      sws_4bits_0_tri_i(3 downto 0) => sws_4bits_0_tri_i(3 downto 0),
      sws_4bits_tri_i(3 downto 0) => sws_4bits_tri_i(3 downto 0),
      vga_b(4 downto 0) => vga_b(4 downto 0),
      vga_g(5 downto 0) => vga_g(5 downto 0),
      vga_hs => vga_hs,
      vga_r(4 downto 0) => vga_r(4 downto 0),
      vga_vs => vga_vs
    );
end STRUCTURE;
