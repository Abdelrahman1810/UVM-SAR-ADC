package sequenceItem_pkg;
import shared_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class ADC_sequenceItem extends uvm_sequence_item;
    `uvm_object_utils(ADC_sequenceItem)
    function new(string name = "ADC_sequenceItem");
        super.new(name);
    endfunction //new()

    rand logic                   rst_n;
    rand logic   [1:0]           sample_rate;
    rand real                    V_in;
    logic   [NUM_BITS-1:0]       D_out;
    real                         V_target;
    logic                        EOC;

	bit 						sample_sig;

    function void Reset();
        rst_n = 0;
        sample_rate = 0;
        V_in = 0.1;
    endfunction

    function string toString();
        string s1 = "\n===============================================================================================================\n";
        string s2 = $sformatf("rst_n = %0d,sample_rate = %0d,V_in = %0f,D_out = %05b,V_target = %0f,EOC = %0d, sample_sig = %0d",rst_n,sample_rate,V_in,D_out,V_target,EOC,sample_sig);
        return {s1, s2, s1};
    endfunction

    constraint c_rst {
        rst_n 	dist {1:=100-RESER_ACTIVE, 	0:=RESER_ACTIVE};
    }

    constraint c_Vin {
        V_in 	inside {[0.1 : shared_pkg::V_SCALE]};
    }

    constraint c_sample_rate_M1 {
        sample_rate == 2'b00;
    }
    constraint c_sample_rate_M2 {
        sample_rate == 2'b01;
    }
    constraint c_sample_rate_M3 {
        sample_rate == 2'b10;
    }
    constraint c_sample_rate_M4 {
        sample_rate == 2'b11;
    }

endclass //ADC_sequenceItem extends superClass
endpackage