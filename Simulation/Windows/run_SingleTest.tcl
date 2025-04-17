vlib work

vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA


vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_NO_RELNOTES +UVM_TESTNAME=ADC_Base_test -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint  \
sim:/top/GMif/*

run -all
capstats

coverage save -onexit -directive -codeAll {../../UCDB_files/cover_ADC_Base_test.ucdb};
quit -f


