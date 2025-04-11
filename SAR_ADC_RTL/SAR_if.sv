interface SAR_if #( 
	parameter NUM_BITS = 4
) (
	input clk
);

 	bit rst_n, sample_sig;
 	bit [1:0] comparator_out;
 	bit valid;
 	bit [NUM_BITS-1:0] digital_signal;

 	modport DUT (output valid, digital_signal,
 					input clk, rst_n, sample_sig, comparator_out);

endinterface : SAR_if