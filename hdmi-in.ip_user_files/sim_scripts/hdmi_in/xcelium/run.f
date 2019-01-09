-makelib xcelium_lib/xilinx_vip -sv \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "C:/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/mmcme2_drp.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/axi_dynclk_S00_AXI.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/axi_dynclk.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_dynclk_0_0/sim/hdmi_in_axi_dynclk_0_0.vhd" \
-endlib
-makelib xcelium_lib/axi_lite_ipif_v3_0_4 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/interrupt_control_v3_1_4 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/8e66/hdl/interrupt_control_v3_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_gpio_v2_0_19 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/c193/hdl/axi_gpio_v2_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_btn_0/sim/hdmi_in_axi_gpio_btn_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_led_0/sim/hdmi_in_axi_gpio_led_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_sw_0/sim/hdmi_in_axi_gpio_sw_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_video_0/sim/hdmi_in_axi_gpio_video_0.vhd" \
-endlib
-makelib xcelium_lib/lib_pkg_v1_0_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/7aff/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/lib_fifo_v1_0_11 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/6078/hdl/lib_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/lib_bmg_v1_0_10 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9340/hdl/lib_bmg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_srl_fifo_v1_0_2 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_datamover_v5_1_19 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec8a/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_vdma_v6_3_5 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b37e/hdl/axi_vdma_v6_3_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vdma_v6_3_5 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b37e/hdl/axi_vdma_v6_3_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_axi_vdma_0_0/sim/hdmi_in_axi_vdma_0_0.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/SyncBase.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/EEPROM_8b.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/TWI_SlaveCtl.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/GlitchFilter.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/SyncAsync.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/DVI_Constants.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/SyncAsyncReset.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/PhaseAlign.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/InputSERDES.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/ChannelBond.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/ResyncToBUFG.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/TMDS_Decoder.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/TMDS_Clocking.vhd" \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d2d3/src/dvi2rgb.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_dvi2rgb_0_0/sim/hdmi_in_dvi2rgb_0_0.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_12 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_proc_sys_reset_0_0/sim/hdmi_in_proc_sys_reset_0_0.vhd" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/5bb9/hdl/sc_util_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/axi_protocol_checker_v2_0_3 -sv \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/03a9/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_3 -sv \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b9a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/processing_system7_vip_v1_0_5 -sv \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70fd/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_processing_system7_0_0/sim/hdmi_in_processing_system7_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ipshared/69dc/src/rgb2vga.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_rgb2vga_0_0/sim/hdmi_in_rgb2vga_0_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_100M_0/sim/hdmi_in_rst_processing_system7_0_100M_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_150M_0/sim/hdmi_in_rst_processing_system7_0_150M_0.vhd" \
-endlib
-makelib xcelium_lib/v_tc_v6_1_12 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/6694/hdl/v_tc_v6_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/v_vid_in_axi4s_v4_0_8 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/d987/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/v_axi4s_vid_out_v4_0_9 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9a07/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_v_axi4s_vid_out_0_0/sim/hdmi_in_v_axi4s_vid_out_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_v_tc_0_0/sim/hdmi_in_v_tc_0_0.vhd" \
  "../../../bd/hdmi_in/ip/hdmi_in_v_tc_1_0/sim/hdmi_in_v_tc_1_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_v_vid_in_axi4s_0_0/sim/hdmi_in_v_vid_in_axi4s_0_0.v" \
-endlib
-makelib xcelium_lib/xlconcat_v2_1_1 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_xlconcat_0_0/sim/hdmi_in_xlconcat_0_0.v" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_5 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/f1c3/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_xlconstant_0_0/sim/hdmi_in_xlconstant_0_0.v" \
-endlib
-makelib xcelium_lib/generic_baseblocks_v2_1_0 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_17 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/6020/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_data_fifo_v2_1_16 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/247d/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_crossbar_v2_1_18 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/15a3/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_xbar_1/sim/hdmi_in_xbar_1.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_xbar_0/sim/hdmi_in_xbar_0.v" \
-endlib
-makelib xcelium_lib/axi_protocol_converter_v2_1_17 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ccfb/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_auto_pc_1/sim/hdmi_in_auto_pc_1.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_m00_data_fifo_0/sim/hdmi_in_m00_data_fifo_0.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_m00_regslice_0/sim/hdmi_in_m00_regslice_0.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_auto_pc_0/sim/hdmi_in_auto_pc_0.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_s01_regslice_0/sim/hdmi_in_s01_regslice_0.v" \
-endlib
-makelib xcelium_lib/axi_clock_converter_v2_1_16 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/e9a5/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_dwidth_converter_v2_1_17 \
  "../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/2839/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/ip/hdmi_in_auto_us_df_0/sim/hdmi_in_auto_us_df_0.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_s00_regslice_0/sim/hdmi_in_s00_regslice_0.v" \
  "../../../bd/hdmi_in/ip/hdmi_in_s00_data_fifo_0/sim/hdmi_in_s00_data_fifo_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/hdmi_in/sim/hdmi_in.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

