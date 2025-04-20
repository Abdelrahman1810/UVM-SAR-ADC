vlib work

set start_time_com [clock microseconds]

vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sampler_gm_if.sv}                            +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sampler_gm.sv}                               +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_Controller_if.sv}                        +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_Controller.sv}                           +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_if.sv}                                   +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR.sv}                                      +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/comparator.sv}                               +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/DAC.sv}                                      +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sample_n_hold.sv}                            +define+QUESTA
vlog                         {../UVM/interface/ADC_intf.sv}                               +define+QUESTA
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_ADC.sv}                                  +define+QUESTA
vlog                         {../UVM/shared_pkg/shared_pkg.sv}                            +define+QUESTA
vlog                         {../UVM/objects/sequenceItem/sequenceItem.sv}                +define+QUESTA
vlog                         {../UVM/objects/sequences/main_sequence.sv}                  +define+QUESTA
vlog                         {../UVM/objects/sequences/rst_sequence.sv}                   +define+QUESTA
vlog                         {../UVM/objects/sequences/mode1_sequence.sv}                 +define+QUESTA
vlog                         {../UVM/objects/sequences/mode2_sequence.sv}                 +define+QUESTA
vlog                         {../UVM/objects/sequences/mode3_sequence.sv}                 +define+QUESTA
vlog                         {../UVM/objects/sequences/mode4_sequence.sv}                 +define+QUESTA
vlog                         {../UVM/objects/configration/configration.sv}                +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/agent/driver/driver.sv}       +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/agent/monitor/monitor.sv}     +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/agent/sequencer/sequencer.sv} +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/agent/agent.sv}               +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/scoreboard/scoreboard.sv}     +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/subscriber/subscriber.sv}     +define+QUESTA
vlog                         {../UVM/testbench_top/test/env/env.sv}                       +define+QUESTA
vlog                         {../UVM/testbench_top/test/test.sv}                          +define+QUESTA
vlog                         {../UVM/testbench_top/top.sv}                                +define+QUESTA

set end_time_com [clock microseconds]
set elapsed_time_com [expr {($end_time_com - $start_time_com)}]

puts "\n============= TEST Compilation Time ============="
puts "===== Compilation Time: ${elapsed_time_com} MicroSeconds ====="
puts "=================================================\n"

vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_NO_RELNOTES +UVM_TESTNAME=ADC_Base_test -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint  \
sim:/top/GMif/*

run -all

# Save coverage database to Reports folder
coverage save -onexit {../UCDB_files/SingleTest_coverage.ucdb}

# Optional summary printed in console
coverage report -summary

quit -sim

# Generate HTML report in Reports folder
vcover report {../UCDB_files/SingleTest_coverage.ucdb} -html -output {../Reports/html}

# Also generate text report
vcover report {../UCDB_files/SingleTest_coverage.ucdb} -output {../Reports/coverage.txt}

# Optional capstats info
capstats
quit -f