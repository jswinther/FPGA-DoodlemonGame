-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Wed Jan  9 09:26:00 2019
-- Host        : NicoLenovo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {C:/Users/bruger/OneDrive - Danmarks Tekniske
--               Universitet/Dokumenter/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_xlconstant_0_0/hdmi_in_xlconstant_0_0_sim_netlist.vhdl}
-- Design      : hdmi_in_xlconstant_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi_in_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of hdmi_in_xlconstant_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of hdmi_in_xlconstant_0_0 : entity is "hdmi_in_xlconstant_0_0,xlconstant_v1_1_5_xlconstant,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of hdmi_in_xlconstant_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of hdmi_in_xlconstant_0_0 : entity is "xlconstant_v1_1_5_xlconstant,Vivado 2018.2";
end hdmi_in_xlconstant_0_0;

architecture STRUCTURE of hdmi_in_xlconstant_0_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  dout(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
