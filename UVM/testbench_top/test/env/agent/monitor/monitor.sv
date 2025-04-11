package monitor_pkg;
import uvm_pkg::*;
import sequenceItem_pkg::*;
`include "uvm_macros.svh"

// monitor class
class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    uvm_analysis_port #(ADC_sequenceItem) mon_port;
    ADC_sequenceItem item;
    virtual ADC_intf v_if;
    virtual sampler_gm_if gm_if;

    function new(string name = "monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_port = new("mon_port", this);

        if (!uvm_config_db#(virtual ADC_intf)::get(this, "", "MONITOR", v_if))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");

        if (!uvm_config_db#(virtual sampler_gm_if)::get(this, "", "ALL", gm_if))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        item = ADC_sequenceItem::type_id::create("item");

            @(posedge v_if.clk);
            item.rst_n = v_if.rst_n;
            item.sample_rate = v_if.sample_rate;
            item.V_in = v_if.V_in; 
            item.EOC = v_if.EOC;
            item.D_out = v_if.D_out;

            item.V_target = v_if.V_target;
            item.sample_sig = gm_if.sample_sig;
            `uvm_info(get_full_name(), item.toString(), UVM_DEBUG)
        mon_port.write(item); // that's mean that monitor will send the data
      end
    endtask //run_phase
endclass //monitor extends uvm_monitor #(ADC_sequenceItem)
endpackage