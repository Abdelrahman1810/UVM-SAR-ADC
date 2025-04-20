@echo off
setlocal

:: -----------------------------------------------------------------
:: -----------------------------------------------------------------
:: IMPORTANT NOTE:                                                ::      
::     MAKE SURE ABOUT HOW MANY CORE DO YOU HAVE IN YOUR MACHINE  ::
:: -----------------------------------------------------------------
:: -----------------------------------------------------------------

:: Define QuestaSim Path
set QPATH=C:\questasim64_2021.1\win64\vsim.exe

:: Define tests to run
set TESTS="ADC_Mode1_Test" "ADC_Mode2_Test" "ADC_Mode3_Test" "ADC_Mode4_Test"

:: Compile the design (once)
vlog -coveropt 3 +cover +acc -f srcfiles_dms.f +define+QUESTA

:: Launch tests in parallel
for %%t in (%TESTS%) do (
    echo Starting test: %%t
    start /B %QPATH% -c -do "set TEST_NAME %%~t; do run_MultiTest_Parallel.tcl" > ../transcripts/%%t.log
)

echo All tests launched in parallel. Check individual transcripts.
endlocal