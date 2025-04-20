LNX_QUESTA_PATH = vsim
WIN_QUESTA_PATH = vsim.exe
SINGLET_SCRIPT = run_SingleTest.tcl
MULTIT_SCRIPT = run_MultiTest_Sequential.tcl

###################################################
##################### WINDOWS #####################
###################################################

win_simSingleTest: 
	clear
	${WIN_QUESTA_PATH} -c -do ${SINGLET_SCRIPT}
	python extract.py

win_simCapstats: 
	clear
	${WIN_QUESTA_PATH} -do ${SINGLET_SCRIPT}
	python extract.py

win_simMultiTest_seq:
	${WIN_QUESTA_PATH} -do ${MULTIT_SCRIPT}
	python extract.py

win_simMultiTest_par:
	.\run_tests_parallel.bat


#####################################################
####################### LINUX #######################
#####################################################



lnx_simSingleTest: 
	clear
	${LNX_QUESTA_PATH} -c -do ${SINGLET_SCRIPT}
	python3 extract.py

lnx_simCapstats: 
	clear
	${LNX_QUESTA_PATH} -do ${SINGLET_SCRIPT}
	python3 extract.py

lnx_simMultiTest_seq:
	${LNX_QUESTA_PATH} -do ${MULTIT_SCRIPT}
	python3 extract.py

lnx_simMultiTest_par:
	chmod +x run_tests_parallel.sh
	./run_tests_parallel.sh


######################## Clean ########################

clean:
	rm -rf work
	rm certe_dump.xml transcript

cleanRun:
	rm -rf workmp.xml transcript
	rm -rf work
	rm ../Reports/*.txt
	rm ../UCDB_files/*.ucdb
	rm *.wlf
	rm -rf ../Reports/html/


	