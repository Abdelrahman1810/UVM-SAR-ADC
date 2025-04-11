//`timescale 1ns/1fs

`ifdef QUESTA
	import mgc_rnm_pkg::*;
`endif

`ifdef VCS
	import snps_msv_nettype_pkg::*;
`endif

module ADC #(
	parameter real 	V_SCALE 	= 16.0,
	parameter 			NUM_BITS	= 4
) (
	ADC_intf.DUT intf
);

	wreal4state V1_CMP, V2_CMP;
	logic CMP_out;

	// For feedback (Input to DAC)
	logic [NUM_BITS-1:0] D_out_internal;
	assign intf.D_out = D_out_internal;

	// Digital Blocks
	// Interface Connections
	SAR_Controller_if 												CTRLif 	(.clk(intf.clk));
	SAR_if 						#(.NUM_BITS(NUM_BITS))	SARif 	(.clk(intf.clk));

	// CTRL Block Inputs
	assign CTRLif.rst_n = intf.rst_n;
	assign CTRLif.sample_rate = intf.sample_rate;

	// SAR Block Inputs
	assign SARif.rst_n = intf.rst_n;
	assign SARif.sample_sig = CTRLif.sample_sig;
	assign SARif.comparator_out = CMP.cmp_out;
	
	// ADC Outputs
	assign D_out_internal = SARif.digital_signal;
	assign intf.EOC 			= SARif.valid;

	// Digital Design Blocks
	SAR_Controller 		CTRL 		(.intf(CTRLif));
	SAR 							SAR0 		(.intf(SARif));

	// Analog (SV-RNM) Blocks

	sample_n_hold 												SH 	(	.clk(CTRLif.sample_sig),
																						.Vin(intf.V_in), 					.V_target(V1_CMP));
	comparator 														CMP (	.clk(intf.clk),
																							.V1(V1_CMP), 					.V2(V2_CMP),
																							.cmp_out(CMP_out));

	DAC 					#(.V_SCALE(V_SCALE), .NUM_BITS(NUM_BITS))
																				D2A (	.D_in(D_out_internal), 	.A_out(V2_CMP));

endmodule : ADC