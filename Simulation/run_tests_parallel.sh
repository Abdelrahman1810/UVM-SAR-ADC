#!/bin/bash

# -----------------------------------------------------------------
# -----------------------------------------------------------------
# IMPORTANT NOTE:                                                #
#     MAKE SURE ABOUT HOW MANY CORES YOU HAVE IN YOUR MACHINE    #
# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Define QuestaSim Path (adjust as needed for Linux)
QPATH="vsim"

# Define tests to run
TESTS=("ADC_Mode1_Test" "ADC_Mode2_Test" "ADC_Mode3_Test" "ADC_Mode4_Test")

# Compile the design (once)
vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA

# Launch tests in parallel
for test in "${TESTS[@]}"; do
    echo "Starting test: $test"
    $QPATH -c -do "setenv TEST_NAME $test; do run_MultiTest_Parallel.tcl" > "$test".log &
done

echo "All tests launched in parallel. Check individual transcripts."
wait
echo "All tests completed."