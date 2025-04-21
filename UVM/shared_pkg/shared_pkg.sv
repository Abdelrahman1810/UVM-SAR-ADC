package shared_pkg;
import uvm_pkg::*;
parameter LOOP = 100;
parameter 			NUM_BITS = 4;
parameter real 		V_SCALE  = 16.0;

// Stimulus Parameters
parameter NUM_TESTS = 100;
parameter RESER_ACTIVE = 0;

parameter RESET_LOOP = 2;
parameter MODE1_LOOP = 1000;
parameter MODE2_LOOP = 1000;
parameter MODE3_LOOP = 1000;
parameter MODE4_LOOP = 1000;
endpackage