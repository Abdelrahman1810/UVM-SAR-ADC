package subscriber_pkg;
import shared_pkg::*;
import sequenceItem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
`define create_obj(type, name) type::type_id::create(name, this);

class ADC_subscriber extends uvm_component;
    `uvm_component_utils(ADC_subscriber)
    uvm_analysis_imp #(ADC_sequenceItem, ADC_subscriber) sub_imp; // subscriber export
    ADC_sequenceItem item;    
    
// ti cover V_in `real` we need some work around
    int V_in_bucket;

    //////////////////////////////////
    //      begin Coverage Group    //
    //////////////////////////////////

    covergroup cvr_gp;
        rst_n_cp: coverpoint item.rst_n {
            // cover
            bins ONE = {0};
            bins ZERO = {1};
        }
        V_in_cp:  coverpoint V_in_bucket {
            // cover
            bins range_1 = {[0:3]};
            bins range_2 = {[4:7]};
            bins range_3 = {[8:11]};
            bins range_4 = {[12:15]};
        }
        sample_rate_cp: coverpoint item.sample_rate {
            bins mode[4] = {0, 1, 2, 3};
            option.auto_bin_max = 0;
        }
        D_out_cp: coverpoint item.D_out {
            bins DIGITAL[16] = {[0:15]};
        }
        EOC_cp: coverpoint item.EOC {
            bins VALID = {1};
        }
    endgroup

    ///////////////////////////////////
    //      finish Coverage Group    //
    ///////////////////////////////////

    function new(string name = "ADC_subscriber", uvm_component parent = null);
        super.new(name, parent);
        cvr_gp = new();
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sub_imp = new("sub_imp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask


    function void write(ADC_sequenceItem t);
        item = t;
        V_in_bucket = int'(t.V_in);
        take_sample();
    endfunction

    task take_sample();
        cvr_gp.sample();
    endtask
endclass //ADC_subscriber extends uvm_subscriber
endpackage