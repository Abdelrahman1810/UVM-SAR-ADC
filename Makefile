QUESTA_PATH = C:\\questasim64_2021.1\\win64\\vsim.exe
SINGLET_SCRIPT = run_SingleTest.tcl
# MULTIT_SCRIPT = run_MultiTest_Sequential.tcl
OUTPUT = transcript.log

sim_single_test:
	clear
	${QUESTA_PATH} -c -do ${SINGLET_SCRIPT} > ${OUTPUT}

# sim_multi_test:
# 	${QUESTA_PATH} -c -do ${MULTIT_SCRIPT} > ${OUTPUT}