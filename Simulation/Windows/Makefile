QUESTA_PATH = C:\\questasim64_2021.1\\win64\\vsim.exe
SINGLET_SCRIPT = run_SingleTest.tcl
MULTIT_SCRIPT = run_MultiTest_Sequential.tcl
OUTPUT = transcript.log
OUTPUT_CAP = transcript_capstats.log

simSingleTest: 
	clear
	${QUESTA_PATH} -c -do ${SINGLET_SCRIPT} > ${OUTPUT}
	python extract.py


sim_capstats: 
	clear
	vsim.exe -do ${SINGLET_SCRIPT}
	python extract.py

simMultiTest_seq:
	vsim.exe -do ${MULTIT_SCRIPT}
	# rm -rf work/ *.xml transcript* vsim*
	python extract.py

sim_multi_test_par:
	.\run_tests_parallel.bat

clean:
	rm *.xml *.wlf transcript
	rm -rf work

	