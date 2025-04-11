interface sampler_gm_if (input clk);

	bit 								rst_n, sample_sig;
	bit [1:0] 					sample_rate;

	modport DUT (output sample_sig,
					input clk, rst_n, sample_rate);
	
endinterface : sampler_gm_if