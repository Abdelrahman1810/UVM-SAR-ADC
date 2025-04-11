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

    //////////////////////////////////
    //      begin Coverage Group    //
    //////////////////////////////////

    covergroup cvr_gp;
        // rst_n_cp: coverpoint item.rst_n {
        //     // cover
        //     bins ONE = {0};
        //     bins ZERO = {1};
        // }
        // V_in_cp:  coverpoint item.V_in {
        //     // cover
        //     bins V_in_range[16] = {[0.1:16.0]};
        // }
        // sample_rate_cp: coverpoint item.sample_rate {
        //     // cover
        // }
        // D_out_cp: coverpoint item.D_out {
        //     // cover
        // }
        // EOC_cp: coverpoint item.EOC {
        //  // bins ONE = {1};
        // }
        // V_target_cp: coverpoint item.V_target {
        //     // cover
        // }
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
        cvr_gp.sample();
    endfunction
endclass //ADC_subscriber extends uvm_subscriber
endpackage