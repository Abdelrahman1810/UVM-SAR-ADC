vlib work

set start_time_com [clock microseconds]
vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA
set end_time_com [clock microseconds]
set elapsed_time_com [expr {($end_time_com - $start_time_com)}]
append test_reports "===== Compilation Time: ${elapsed_time_com} MicroSeconds =====\n"

vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_NO_RELNOTES +UVM_TESTNAME=ADC_Base_test -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint  \
sim:/top/GMif/*

run -all
capstats
puts "\n============= TEST Compilation Time ============="
puts $test_reports
puts "================================================="
coverage save -onexit -directive -codeAll {../../UCDB_files/cover_ADC_Base_test.ucdb};
quit -f


