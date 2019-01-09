-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Wed Jan  9 09:26:00 2019
-- Host        : NicoLenovo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {C:/Users/bruger/OneDrive - Danmarks Tekniske
--               Universitet/Dokumenter/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_xlconstant_0_0/hdmi_in_xlconstant_0_0_stub.vhdl}
-- Design      : hdmi_in_xlconstant_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hdmi_in_xlconstant_0_0 is
  Port ( 
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end hdmi_in_xlconstant_0_0;

architecture stub of hdmi_in_xlconstant_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "dout[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xlconstant_v1_1_5_xlconstant,Vivado 2018.2";
begin
end;
