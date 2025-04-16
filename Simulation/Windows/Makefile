QUESTA_PATH = C:\\questasim64_2021.1\\win64\\vsim.exe
SINGLET_SCRIPT = run_SingleTest.tcl
MULTIT_SCRIPT = run_MultiTest_Sequential.tcl
OUTPUT = transcript.log

sim_single_test:
	clear
	${QUESTA_PATH} -c -do ${SINGLET_SCRIPT} > ${OUTPUT}
 
sim_sequential:
	vsim.exe -do ${MULTIT_SCRIPT}
 
sim_parallel:
	.\run_tests_parallel.bat

clean:
	rm ../../transcripts/*.log
	rm *.xml *.wlf wlft* transcript
	rm -rf work