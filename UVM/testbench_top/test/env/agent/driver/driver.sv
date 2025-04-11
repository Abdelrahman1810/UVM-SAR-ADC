package driver_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

import sequenceItem_pkg::*;

class driver extends uvm_driver #(ADC_sequenceItem);
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
    endfunction

    virtual ADC_intf v_if;
    virtual sampler_gm_if gm_if;
    ADC_sequenceItem item;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual ADC_intf)::get(this, "", "DRIVER", v_if))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");

        if (!uvm_config_db#(virtual sampler_gm_if)::get(this, "", "ALL", gm_if))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = ADC_sequenceItem::type_id::create("item");
            seq_item_port.get_next_item(item);

                @(negedge v_if.clk);
                // Drive Digital Signals (RNM)
                v_if.rst_n 		<= item.rst_n;
                v_if.sample_rate <= item.sample_rate;
                v_if.V_in 		<= item.V_in;

                gm_if.rst_n 		<= item.rst_n;
                gm_if.sample_rate 	<= item.sample_rate;
                
            seq_item_port.item_done();
        end
    endtask
endclass //driver extends superClass
endpackage