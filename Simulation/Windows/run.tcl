vlib work

set compile_start_time [clock milliseconds]
vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA
set compile_end_time [clock milliseconds]
set compile_duration [expr {$compile_end_time - $compile_start_time}]
puts "COMPILATION TIME (in milliseconds): $compile_duration"

set sim_start_time [clock milliseconds]
vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_TESTNAME=ADC_Base_test -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint sim:/top/GMif/*

run -all
set sim_end_time [clock milliseconds]
set sim_duration [expr {$sim_end_time - $sim_start_time}]
puts "SIMULATION TIME (in milliseconds): $sim_duration"

memstat > memory_report.txt

coverage save -onexit -directive -codeAll cover_ADC_Base_test.ucdb;
quit -sim
