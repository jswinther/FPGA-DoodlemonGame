# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "C:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.runs/hdmi_in_axi_vdma_0_0_synth_1/.Xil/Vivado-5700-DESKTOP-SHDFERO/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7z010clg400-1
    source $::env(HRT_TCL_PATH)/rtSynthParallelPrep.tcl
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv -include c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl {
      C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
      C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv
      C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog -include c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.v
      rt::read_vhdl -lib lib_cdc_v1_0_2 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd
      rt::read_vhdl -lib lib_pkg_v1_0_2 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd
      rt::read_vhdl -lib lib_fifo_v1_0_12 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/544a/hdl/lib_fifo_v1_0_rfs.vhd
      rt::read_vhdl -lib lib_bmg_v1_0_11 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/556c/hdl/lib_bmg_v1_0_rfs.vhd
      rt::read_vhdl -lib lib_srl_fifo_v1_0_2 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd
      rt::read_vhdl -lib axi_datamover_v5_1_20 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/dfb3/hdl/axi_datamover_v5_1_vh_rfs.vhd
      rt::read_vhdl -lib axi_vdma_v6_3_6 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/58e2/hdl/axi_vdma_v6_3_rfs.vhd
      rt::read_vhdl -lib blk_mem_gen_v8_4_2 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/37c2/hdl/blk_mem_gen_v8_4_vhsyn_rfs.vhd
      rt::read_vhdl -lib fifo_generator_v13_2_3 c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ipshared/64f4/hdl/fifo_generator_v13_2_vhsyn_rfs.vhd
      rt::read_vhdl -lib xil_defaultlib c:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.srcs/sources_1/bd/hdmi_in/ip/hdmi_in_axi_vdma_0_0/synth/hdmi_in_axi_vdma_0_0.vhd
      rt::read_vhdl -lib xpm C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top hdmi_in_axi_vdma_0_0
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter elaborateRtlOnlyFlow false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "C:/Users/manniche/Documents/GitHub/3Ugers3Semester/hdmi-in.runs/hdmi_in_axi_vdma_0_0_synth_1/.Xil/Vivado-5700-DESKTOP-SHDFERO/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}