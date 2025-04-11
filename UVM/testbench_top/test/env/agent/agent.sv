package agent_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

import driver_pkg::*;
import monitor_pkg::*;
import sequencer_pkg::*;
import config_pkg::*;
import sequenceItem_pkg::*;
    
class agent extends uvm_agent;
`uvm_component_utils(agent)

    function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
    endfunction //new()

    driver drv;
    monitor mon;
    sequencer sqr;
    ADC_config cfg; 
    uvm_analysis_port #(ADC_sequenceItem) agt_port; // agent is a port

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = driver::type_id::create("drv", this);
        mon = monitor::type_id::create("mon", this);
        sqr = sequencer::type_id::create("sqr", this);
        cfg = ADC_config::type_id::create("cfg", this);

        if (!uvm_config_db#(ADC_config)::get(this, "", "AGENT", cfg))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");

        uvm_config_db#(virtual ADC_intf)::set(this, "drv", "DRIVER", cfg.v_if);    
        uvm_config_db#(virtual ADC_intf)::set(this, "mon", "MONITOR", cfg.v_if);    
        agt_port = new("agt_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        // drv.v_if = cfg.v_if;
        // mon.v_if = cfg.v_if;
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_port.connect(agt_port);
    endfunction //connect_phase
endclass //agent extends uvm_agent
endpackage