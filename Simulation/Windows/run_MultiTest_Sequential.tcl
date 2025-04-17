vlib work

vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA

set test_reports ""
set ucdb_files ""

foreach test {ADC_Mode1_Test ADC_Mode2_Test ADC_Mode3_Test ADC_Mode4_Test} {
    puts "Running test: $test"
    
    # Capture start time
    set start_time [clock milliseconds]

    vsim -coverage -vopt +UVM_VERBOSITY=UVM_LOW work.top +UVM_NO_RELNOTES +UVM_TESTNAME=$test -c -do "
        add wave *;
        run -all
        coverage save -onexit -directive -codeAll {../../UCDB_files/cover_${test}.ucdb};
    "
    
    set end_time [clock milliseconds]

    # Compute elapsed time
    set elapsed_time [expr {($end_time - $start_time) / 1000.0}]

    
    capstats

    # Store test report in the list
    append test_reports "Test: $test | Execution Time: ${elapsed_time} seconds\n"

    # Append UCDB file for merging
    append ucdb_files "cover_${test}.ucdb "
}

# Merge UCDB files
# set merged_ucdb "Coverage_report_merged.ucdb"
# vcover merge $merged_ucdb {*}$ucdb_files
# puts "Merged UCDB file created: $merged_ucdb"

# Print Final Test Execution Summary
puts "\n======== TEST EXECUTION SUMMARY ========"
puts $test_reports
puts "========================================"

quit -f
# Open merged UCDB in QuestaSim Coverage Viewer
# vsim -viewcov $merged_ucdb
# puts "Opened merged UCDB in QuestaSim Coverage Viewer"
