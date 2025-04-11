package config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

// Configration class
class ADC_config extends uvm_object;
    `uvm_object_utils(ADC_config)    
    virtual ADC_intf v_if;
    function new(string name = "ADC_config");
        super.new(name);
    endfunction //new()
endclass //ADC_config

// Configration class
class GM_Sample_config extends uvm_object;
    `uvm_object_utils(GM_Sample_config)    
    virtual sampler_gm_if v_if;
    function new(string name = "GM_Sample_config");
        super.new(name);
    endfunction //new()
endclass //GM_Sample_config
endpackage