vlib work
vlib activehdl

vlib activehdl/xilinx_vip
vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/interrupt_control_v3_1_4
vlib activehdl/axi_gpio_v2_0_20
vlib activehdl/lib_pkg_v1_0_2
vlib activehdl/fifo_generator_v13_2_3
vlib activehdl/lib_fifo_v1_0_12
vlib activehdl/blk_mem_gen_v8_4_2
vlib activehdl/lib_bmg_v1_0_11
vlib activehdl/lib_srl_fifo_v1_0_2
vlib activehdl/axi_datamover_v5_1_20
vlib activehdl/axi_vdma_v6_3_6
vlib activehdl/proc_sys_reset_v5_0_13
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_4
vlib activehdl/processing_system7_vip_v1_0_6
vlib activehdl/v_tc_v6_1_13
vlib activehdl/v_vid_in_axi4s_v4_0_9
vlib activehdl/v_axi4s_vid_out_v4_0_10
vlib activehdl/xlconcat_v2_1_1
vlib activehdl/xlconstant_v1_1_5
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/axi_register_slice_v2_1_18
vlib activehdl/axi_data_fifo_v2_1_17
vlib activehdl/axi_crossbar_v2_1_19
vlib activehdl/axi_protocol_converter_v2_1_18
vlib activehdl/axi_clock_converter_v2_1_17
vlib activehdl/axi_dwidth_converter_v2_1_18

vmap xilinx_vip activehdl/xilinx_vip
vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap interrupt_control_v3_1_4 activehdl/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_20 activehdl/axi_gpio_v2_0_20
vmap lib_pkg_v1_0_2 activehdl/lib_pkg_v1_0_2
vmap fifo_generator_v13_2_3 activehdl/fifo_generator_v13_2_3
vmap lib_fifo_v1_0_12 activehdl/lib_fifo_v1_0_12
vmap blk_mem_gen_v8_4_2 activehdl/blk_mem_gen_v8_4_2
vmap lib_bmg_v1_0_11 activehdl/lib_bmg_v1_0_11
vmap lib_srl_fifo_v1_0_2 activehdl/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_20 activehdl/axi_datamover_v5_1_20
vmap axi_vdma_v6_3_6 activehdl/axi_vdma_v6_3_6
vmap proc_sys_reset_v5_0_13 activehdl/proc_sys_reset_v5_0_13
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_4 activehdl/axi_vip_v1_1_4
vmap processing_system7_vip_v1_0_6 activehdl/processing_system7_vip_v1_0_6
vmap v_tc_v6_1_13 activehdl/v_tc_v6_1_13
vmap v_vid_in_axi4s_v4_0_9 activehdl/v_vid_in_axi4s_v4_0_9
vmap v_axi4s_vid_out_v4_0_10 activehdl/v_axi4s_vid_out_v4_0_10
vmap xlconcat_v2_1_1 activehdl/xlconcat_v2_1_1
vmap xlconstant_v1_1_5 activehdl/xlconstant_v1_1_5
vmap generic_baseblocks_v2_1_0 activehdl/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_18 activehdl/axi_register_slice_v2_1_18
vmap axi_data_fifo_v2_1_17 activehdl/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 activehdl/axi_crossbar_v2_1_19
vmap axi_protocol_converter_v2_1_18 activehdl/axi_protocol_converter_v2_1_18
vmap axi_clock_converter_v2_1_17 activehdl/axi_clock_converter_v2_1_17
vmap axi_dwidth_converter_v2_1_18 activehdl/axi_dwidth_converter_v2_1_18

vlog -work xilinx_vip  -sv2k12 "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/mmcme2_drp.v" \

vcom -work xil_defaultlib -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/axi_dynclk_S00_AXI.vhd" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/9097/src/axi_dynclk.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_axi_dynclk_0_0/sim/hdmi_in_axi_dynclk_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_20 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/a7c9/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_btn_0/sim/hdmi_in_axi_gpio_btn_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_led_0/sim/hdmi_in_axi_gpio_led_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_sw_0/sim/hdmi_in_axi_gpio_sw_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_axi_gpio_video_0/sim/hdmi_in_axi_gpio_video_0.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_12 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/544a/hdl/lib_fifo_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_4_2  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/37c2/simulation/blk_mem_gen_v8_4.v" \

vcom -work lib_bmg_v1_0_11 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/556c/hdl/lib_bmg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_20 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/dfb3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vlog -work axi_vdma_v6_3_6  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.v" \

vcom -work axi_vdma_v6_3_6 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.vhd" \

vcom -work xil_defaultlib -93 \
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

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/hdmi_in/ip/hdmi_in_proc_sys_reset_0_0/sim/hdmi_in_proc_sys_reset_0_0.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_4  -sv2k12 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/98af/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_6  -sv2k12 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_processing_system7_0_0/sim/hdmi_in_processing_system7_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/hdmi_in/ipshared/69dc/src/rgb2vga.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_rgb2vga_0_0/sim/hdmi_in_rgb2vga_0_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_100M_0/sim/hdmi_in_rst_processing_system7_0_100M_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_150M_0/sim/hdmi_in_rst_processing_system7_0_150M_0.vhd" \

vcom -work v_tc_v6_1_13 -93 \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/a92c/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_9  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b2aa/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_10  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/a87e/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_v_axi4s_vid_out_0_0/sim/hdmi_in_v_axi4s_vid_out_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/hdmi_in/ip/hdmi_in_v_tc_0_0/sim/hdmi_in_v_tc_0_0.vhd" \
"../../../bd/hdmi_in/ip/hdmi_in_v_tc_1_0/sim/hdmi_in_v_tc_1_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_v_vid_in_axi4s_0_0/sim/hdmi_in_v_vid_in_axi4s_0_0.v" \

vlog -work xlconcat_v2_1_1  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_xlconcat_0_0/sim/hdmi_in_xlconcat_0_0.v" \

vlog -work xlconstant_v1_1_5  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/4649/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_xlconstant_0_0/sim/hdmi_in_xlconstant_0_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_17  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_xbar_0/sim/hdmi_in_xbar_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_xbar_1/sim/hdmi_in_xbar_1.v" \
"../../../bd/hdmi_in/ip/hdmi_in_s00_regslice_0/sim/hdmi_in_s00_regslice_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_s00_data_fifo_0/sim/hdmi_in_s00_data_fifo_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_s01_regslice_0/sim/hdmi_in_s01_regslice_0.v" \

vlog -work axi_protocol_converter_v2_1_18  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/7a04/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_17  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/693a/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work axi_dwidth_converter_v2_1_18  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/0815/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ec67/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/70cf/hdl" "+incdir+../../../../hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/hdmi_in/ip/hdmi_in_auto_us_df_0/sim/hdmi_in_auto_us_df_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_m00_data_fifo_0/sim/hdmi_in_m00_data_fifo_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_m00_regslice_0/sim/hdmi_in_m00_regslice_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_auto_pc_0/sim/hdmi_in_auto_pc_0.v" \
"../../../bd/hdmi_in/ip/hdmi_in_auto_pc_1/sim/hdmi_in_auto_pc_1.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/hdmi_in/sim/hdmi_in.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

