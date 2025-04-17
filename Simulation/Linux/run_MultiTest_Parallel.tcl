####################################################################
####################################################################
## IMPORTANT NOTE:                                                ##       
##     MAKE SURE ABOUT HOW MANY CORE DO YOU HAVE IN YOUR MACHINE  ##  
####################################################################
####################################################################

# Get test name from environment variable
if {[info exists ::env(TEST_NAME)]} {
    set test_name $::env(TEST_NAME)
} elseif {[info exists TEST_NAME]} {
    set test_name $TEST_NAME
} else {
    puts "Error: No test name specified!"
    quit -f
}

vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top +UVM_TESTNAME=${test_name} -classdebug -uvmcontrol=all -cover
run -all
quit -f