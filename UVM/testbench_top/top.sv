module top ();
import uvm_pkg::*;
`include "uvm_macros.svh"
import test_pkg::*;
import shared_pkg::*;
	//Import the UVM library
	import uvm_pkg::*;
	// import uvm_ms_pkg::*;

	//Include the UVM macros
	`include "uvm_macros.svh"
	// `include "uvm_ms.svh"
    
    bit clk;

    initial begin
        forever begin
            #5 clk = ~clk; // 10 ns
        end
    end

    ADC_intf intf(clk);
    // ADC_Encrypt aes_encr(
    //         .in(intf.in),
    //         .key(intf.key),
    //         .out(intf.out)
    // );

// Golden Model Instantiation for Sample Signal
	sampler_gm_if 										GMif 	(clk);
	// assign GMif.rst_n = intf.rst_n;
	// assign GMif.sample_rate = intf.sample_rate;
	sampler_gm 		#(.NUM_BITS(shared_pkg::NUM_BITS)) 	GM 		(GMif);

	// Only Connect DUT to Digital Interface (Compatible with Pure Digital / RNM)
	ADC #(.V_SCALE(shared_pkg::V_SCALE)) DUT (intf);

    assign intf.V_target = DUT.SH.V_target;

    initial begin
        uvm_config_db#(virtual ADC_intf)::set(null, "uvm_test_top", "INTF", intf);
        uvm_config_db#(virtual sampler_gm_if)::set(null, "uvm_test_top", "GMINTF", GMif);
        run_test("ADC_test");
    end    
endmodule
    