# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.cache/wt [current_project]
set_property parent.project_path C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
set_property ip_repo_paths {
  c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.ipdefs/repo_0_0
  c:/Users/s174873/Dropbox/ip_repo
} [current_project]
update_ip_catalog
set_property ip_output_repo c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/imports/hdl/hdmi_in_wrapper.vhd
add_files C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/hdmi_in.bd
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_btn_0/hdmi_in_axi_gpio_btn_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_btn_0/hdmi_in_axi_gpio_btn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_btn_0/hdmi_in_axi_gpio_btn_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_led_0/hdmi_in_axi_gpio_led_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_led_0/hdmi_in_axi_gpio_led_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_led_0/hdmi_in_axi_gpio_led_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_sw_0/hdmi_in_axi_gpio_sw_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_sw_0/hdmi_in_axi_gpio_sw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_sw_0/hdmi_in_axi_gpio_sw_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_video_0/hdmi_in_axi_gpio_video_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_video_0/hdmi_in_axi_gpio_video_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_gpio_video_0/hdmi_in_axi_gpio_video_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_vdma_0_0/hdmi_in_axi_vdma_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_vdma_0_0/hdmi_in_axi_vdma_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_vdma_0_0/hdmi_in_axi_vdma_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_dvi2rgb_0_0/src/dvi2rgb.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_dvi2rgb_0_0/src/dvi2rgb_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_proc_sys_reset_0_0/hdmi_in_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_proc_sys_reset_0_0/hdmi_in_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_processing_system7_0_0/hdmi_in_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_100M_0/hdmi_in_rst_processing_system7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_100M_0/hdmi_in_rst_processing_system7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_150M_0/hdmi_in_rst_processing_system7_0_150M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_rst_processing_system7_0_150M_0/hdmi_in_rst_processing_system7_0_150M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_v_axi4s_vid_out_0_0/hdmi_in_v_axi4s_vid_out_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_v_tc_0_0/hdmi_in_v_tc_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_v_tc_1_0/hdmi_in_v_tc_1_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_v_vid_in_axi4s_0_0/hdmi_in_v_vid_in_axi4s_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_s00_regslice_0/hdmi_in_s00_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_s00_regslice_0/hdmi_in_s00_regslice_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_s00_data_fifo_0/hdmi_in_s00_data_fifo_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_s01_regslice_0/hdmi_in_s01_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_s01_regslice_0/hdmi_in_s01_regslice_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_auto_us_df_0/hdmi_in_auto_us_df_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_auto_us_df_0/hdmi_in_auto_us_df_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_auto_us_df_0/hdmi_in_auto_us_df_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_m00_data_fifo_0/hdmi_in_m00_data_fifo_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_m00_regslice_0/hdmi_in_m00_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_m00_regslice_0/hdmi_in_m00_regslice_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_auto_pc_0/hdmi_in_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_auto_pc_1/hdmi_in_auto_pc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/hdmi_in_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/constrs_1/imports/constraints/ZYBO_Master.xdc
set_property used_in_implementation false [get_files C:/Users/s174873/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/constrs_1/imports/constraints/ZYBO_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top hdmi_in_wrapper -part xc7z010clg400-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef hdmi_in_wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file hdmi_in_wrapper_utilization_synth.rpt -pb hdmi_in_wrapper_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
