QUESTASIM = vsim.exe
SINGLET_SCRIPT = run_SingleTest.tcl
MULTIT_SCRIPT = run_MultiTest_Sequential.tcl

simSingleTest: 
	clear
	${QUESTASIM} -c -do ${SINGLET_SCRIPT}
	python extract.py


sim_capstats: 
	clear
	${QUESTASIM} -do ${SINGLET_SCRIPT}
	python extract.py

simMultiTest_seq:
	${QUESTASIM} -do ${MULTIT_SCRIPT}
	python extract.py

sim_multi_test_par:
	.\run_tests_parallel.bat

clean:
	rm *.xml *.wlf transcript*
	rm -rf work

	