package test_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import env_pkg::*;
import main_seq_pkg::*;
import rst_seq_pkg::*;
import config_pkg::*;
import mode4_seq_pkg::*;
import mode3_seq_pkg::*;
import mode2_seq_pkg::*;
import mode1_seq_pkg::*;

class ADC_test extends uvm_test;
    `uvm_component_utils(ADC_test)
    function new(string name = "ADC_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    ADC_config cfg;
    GM_Sample_config cfg_GM;
    main_sequence main_seq;
    rst_sequence rst_seq;
    mode1_sequence md1_seq;
    mode2_sequence md2_seq;
    mode3_sequence md3_seq;
    mode4_sequence md4_seq;
    Env env;

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = ADC_config::type_id::create("cfg", this);
    cfg_GM = GM_Sample_config::type_id::create("cfg_GM", this);
    main_seq = main_sequence::type_id::create("main_seq", this);
    rst_seq = rst_sequence::type_id::create("rst_seq", this);
    md1_seq = mode1_sequence::type_id::create("md1_seq", this);
    md2_seq = mode2_sequence::type_id::create("md2_seq", this);
    md3_seq = mode3_sequence::type_id::create("md3_seq", this);
    md4_seq = mode4_sequence::type_id::create("md4_seq", this);
    env = Env::type_id::create("env", this);

    if (!uvm_config_db#(virtual ADC_intf)::get(this, "", "INTF", cfg.v_if))
        `uvm_fatal(get_full_name(), "Unable to get ADC config");

    if (!uvm_config_db#(virtual sampler_gm_if)::get(this, "", "GMINTF", cfg_GM.v_if))
        `uvm_fatal(get_full_name(), "Unable to get sampler_gm config");

    uvm_config_db#(virtual sampler_gm_if)::set(this, "*", "ALL", cfg_GM.v_if);
    uvm_config_db#(ADC_config)::set(this, "env", "ENV", cfg);
    endfunction

    task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    #10;
    `uvm_info(get_full_name(), "rais objection", UVM_LOW)

    rst_seq.start(env.agt.sqr);
    
    `uvm_info(get_full_name(), "MODE 1", UVM_LOW)
    md1_seq.start(env.agt.sqr);

    rst_seq.start(env.agt.sqr);
    

    `uvm_info(get_full_name(), "MODE 2", UVM_LOW)
    md2_seq.start(env.agt.sqr);
    
    rst_seq.start(env.agt.sqr);

    `uvm_info(get_full_name(), "MODE 3", UVM_LOW)
    md3_seq.start(env.agt.sqr);
    
    rst_seq.start(env.agt.sqr);
    
    `uvm_info(get_full_name(), "MODE 4", UVM_LOW)
    md4_seq.start(env.agt.sqr);
    
    #10;
    `uvm_info(get_full_name(), "drop objection", UVM_LOW)
    
    phase.drop_objection(this);
    endtask
endclass //ADC_test extends uvm_test
endpackage