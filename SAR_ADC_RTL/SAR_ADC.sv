//`timescale 1ns/1fs

`ifdef QUESTA
	import mgc_rnm_pkg::*;
`endif

`ifdef VCS
	import snps_msv_nettype_pkg::*;
`endif

module SAR_ADC #(
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
	SAR_Controller_if CTRLif (
		.clk(intf.clk)
	);
	SAR_if #(
		.NUM_BITS(NUM_BITS)
	) SARif (
		.clk(intf.clk)
	);

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

	sample_n_hold SH (
		.clk(CTRLif.sample_sig),
		.Vin(intf.V_in),
		.V_target(V1_CMP)
	);
	comparator CMP (
		.clk(intf.clk),
		.V1(V1_CMP),
		.V2(V2_CMP),
		.cmp_out(CMP_out)
	);

	DAC #(
		.V_SCALE(V_SCALE),
		.NUM_BITS(NUM_BITS)
	) D2A (
		.D_in(D_out_internal),
		.A_out(V2_CMP)
	);

///////////////////////////////////////////////////////////
/////////////////////////// SVA ///////////////////////////
///////////////////////////////////////////////////////////

`ifdef ASSERTIONS

	`define DISRST disable iff(!intf.rst_n)

	///////////////////////////////////////////////////////////////////////////////
	///////////////////          CONCURRENT ASSERTIONS          ///////////////////
	///////////////////////////////////////////////////////////////////////////////

	function int quantize(input real vin);
		return int'($floor(vin / 1.0));
	endfunction

	sequence rise_eoc;
		$rose(intf.EOC);
	endsequence

	property Vtarget_Vin;
		@(posedge intf.clk) `DISRST
			$changed(SH.V_target) |-> (SH.V_target == intf.V_in)
		;
	endproperty

	sequence Dout_Vin(int x);
		$past(intf.D_out) == quantize($past(intf.V_in, x));
			/// `|=>` make delay with one clk cycle plus
	endsequence

	property eoc_Vin_Dout(int x);
		@(posedge intf.clk) `DISRST
			(rise_eoc |=> Dout_Vin(x))
		;
	endproperty

	property comp;
		@(negedge intf.clk) `DISRST
			((V1_CMP > V2_CMP) |=> CMP_out)
		;
	endproperty

	property counterValid;
		@(posedge intf.clk) `DISRST
			(SAR0.counter == 4 /*4 clk cycle*/ |=> intf.EOC)
		;
	endproperty

	property eoc_after_4_clks;
		@(posedge intf.clk) `DISRST
			$changed(SH.V_target) |=> ##4 $rose(intf.EOC)
		;
	endproperty

	property V_target_sample_rate_check;
		@(posedge intf.clk) `DISRST
		
			$changed(SH.V_target) |->
				case (intf.sample_rate)
				2'b00: ##5  $changed(SH.V_target);
				2'b01: ##10 $changed(SH.V_target);
				2'b10: ##15 $changed(SH.V_target);
				2'b11: ##20 $changed(SH.V_target);
				endcase
		;
	endproperty

	assert_Vtarget_Vin: assert property (Vtarget_Vin)
	else
		$display("[ASSERT FAIL] At time %0t: V_target did not match V_in", $time);
 
	assert_Vtarget_mode: assert property (V_target_sample_rate_check)
	else
		$display("[ASSERT FAIL] At time %0t: V_target did not change at correct interval based on sample_rate %b", $time, intf.sample_rate);
 
	assert_eoc_4clks: 	 assert property (eoc_after_4_clks)
	else 
		$display("[ASSERT FAIL] At time %0t: V_target changed but EOC did not rise after 4 cycles.", $time);

	assert_dout:         assert property (eoc_Vin_Dout(6))
	else
		$display($time, ": Assertion Fail\n past5V_in = %0f, D_out = %0d",($past(intf.V_in, 6)), $past(intf.D_out));

	assert_comparator:   assert property (comp)
	else 
		$display($time, ": Assertion Fail\n V1_CMP = %0f, V2_CMP = %0f, CMP_out = %0f", V1_CMP, V2_CMP, CMP_out);

	assert_counterValid: assert property (counterValid)
	else
		$display($time, ": Assertion Fail\n Counter = %0b, EOC = %0b", SAR0.counter, intf.EOC);

	//////////////////////////////////////////////////////////////////////////////
	///////////////////          IMMEDIATE ASSERTIONS          ///////////////////
	//////////////////////////////////////////////////////////////////////////////

	always_comb begin
		if (!intf.rst_n) begin
			assert_rst_Dout: 	assert final (intf.D_out == 4'b1000)
						else
							$error("Assertion rst_Dout failed!");
			assert_rst_EOC: 	assert final (intf.EOC == 0)
						else
							$error("Assertion rst_EOC failed!");
		end
	end

	////////////////////////////////////////////////////////////////////////////
	////////////////////////          COVERAGE          ////////////////////////
	////////////////////////////////////////////////////////////////////////////

	cover_Vtarget_Vin: 	cover property (Vtarget_Vin);
 
	cover_Vtarget_mode: cover property (V_target_sample_rate_check);
 
	cover_eoc_4clks: 	cover property (eoc_after_4_clks);

	cover_dout:         cover property (eoc_Vin_Dout(6));

	cover_comparator:   cover property (comp);

	cover_counterValid: cover property (counterValid);

	always_comb begin
		if (!intf.rst_n) begin
			cover_rst_Dout: cover final (intf.D_out == 4'b1000);
			cover_rst_EOC: 	cover final (intf.EOC == 0);
		end
	end
`endif


endmodule : SAR_ADC