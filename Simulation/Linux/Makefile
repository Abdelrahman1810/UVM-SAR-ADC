QUESTA_PATH = vsim
SINGLET_SCRIPT = run_SingleTest.tcl
MULTIT_SCRIPT = run_MultiTest_Sequential.tcl

simSingleTest: 
	clear
	${QUESTA_PATH} -c -do ${SINGLET_SCRIPT}
	python3 extract.py

sim_capstats: 
	clear
	${QUESTA_PATH} -do ${SINGLET_SCRIPT}
	python3 extract.py

simMultiTest_seq:
	${QUESTA_PATH} -do ${MULTIT_SCRIPT}
	python3 extract.py

simMultiTest_par:
	.\run_tests_parallel.bat

clean:
	rm *.xml *.wlf transcript*
	rm -rf work

	