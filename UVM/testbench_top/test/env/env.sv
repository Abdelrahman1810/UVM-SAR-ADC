package env_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

import agent_pkg::*;
import config_pkg::*;
import scoreboard_pkg::*;
import subscriber_pkg::*;

class Env extends uvm_env;
`uvm_component_utils(Env)
function new(string name = "Env", uvm_component parent = null);
super.new(name, parent);        
endfunction

    agent agt;
    ADC_config cfg;
    ADC_scoreboard scb;
    ADC_subscriber sub;

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        agt = agent::type_id::create("agt", this);
        cfg = ADC_config::type_id::create("cfg", this);
        scb = ADC_scoreboard::type_id::create("scb", this);
        sub = ADC_subscriber::type_id::create("sub", this);
        //
        if (!uvm_config_db#(ADC_config)::get(this, "", "ENV", cfg))
            `uvm_fatal(get_full_name(), "Unable to get ADC config");

        uvm_config_db#(ADC_config)::set(this, "agt", "AGENT", cfg);
    endfunction

    function void connect_phase(uvm_phase phase);  
        super.connect_phase(phase);
        agt.agt_port.connect(scb.scb_imp);   
        agt.agt_port.connect(sub.sub_imp);   
        // agt.agt_port.connect(cov.cov_export);   
    endfunction
endclass
endpackage