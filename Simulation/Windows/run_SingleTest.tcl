vlib work

vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA


vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_TESTNAME=ADC_Base_test -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint  \
sim:/top/GMif/*

run -all

coverage save -onexit -directive -codeAll cover_ADC_Base_test.ucdb;
# quit -sim

coverage report -detail -cvg -directive -comments -output {Reports/Directive_Coverage_report_ADC_Base_test.txt}
coverage report -detail -cvg -directive -comments -output {Reports/FUNCTION_COVER_ADC_Base_test.txt} {}
quit -sim
vcover report cover_ADC_Base_test.ucdb -details -all -annotate -output {Reports/code_coverage_ADC_Base_test.txt}
