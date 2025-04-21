vlib work

vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sampler_gm_if.sv}                            +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sampler_gm.sv}                               +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_Controller_if.sv}                        +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_Controller.sv}                           +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_if.sv}                                   +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR.sv}                                      +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/comparator.sv}                               +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/DAC.sv}                                      +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/sample_n_hold.sv}                            +define+QUESTA+ASSERTIONS
vlog                         {../UVM/interface/ADC_intf.sv}                               +define+QUESTA+ASSERTIONS
vlog -coveropt 3 +cover +acc {../SAR_ADC_RTL/SAR_ADC.sv}                                  +define+QUESTA+ASSERTIONS
vlog                         {../UVM/shared_pkg/shared_pkg.sv}                            +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequenceItem/sequenceItem.sv}                +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/main_sequence.sv}                  +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/rst_sequence.sv}                   +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/mode1_sequence.sv}                 +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/mode2_sequence.sv}                 +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/mode3_sequence.sv}                 +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/sequences/mode4_sequence.sv}                 +define+QUESTA+ASSERTIONS
vlog                         {../UVM/objects/configration/configration.sv}                +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/agent/driver/driver.sv}       +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/agent/monitor/monitor.sv}     +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/agent/sequencer/sequencer.sv} +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/agent/agent.sv}               +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/scoreboard/scoreboard.sv}     +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/subscriber/subscriber.sv}     +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/env/env.sv}                       +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/test/test.sv}                          +define+QUESTA+ASSERTIONS
vlog                         {../UVM/testbench_top/top.sv}                                +define+QUESTA+ASSERTIONS


foreach test {ADC_Mode1_Test ADC_Mode2_Test ADC_Mode3_Test ADC_Mode4_Test} {
    puts "Running test: $test"
    
    # Capture start time
    set start_time [clock milliseconds]

    vsim -coverage -vopt +UVM_VERBOSITY=UVM_LOW work.top +UVM_NO_RELNOTES +UVM_TESTNAME=$test -c -do "
        run -all;
        coverage save -onexit {../UCDB_files/cover_${test}.ucdb};
        coverage report -summary;
    "
    
    set end_time [clock milliseconds]

    # Compute elapsed time
    set elapsed_time [expr {($end_time - $start_time) / 1000.0}]


    quit -sim

    # Generate HTML report in Reports folder
    vcover report {../UCDB_files/cover_${test}.ucdb} -html -output {../Reports/html_MultiTest}

    # Also generate text report
    vcover report {../UCDB_files/cover_${test}.ucdb} -output {../Reports/coverage_MultiTest.txt}

    capstats
}

quit -f
