interface ADC_intf #(
    parameter NUM_BITS = 4
) (
    input clk
);

    //timeunit 1ns;
    //timeprecision 1fs;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    logic                   rst_n;
    logic   [1:0]           sample_rate;
    real                    V_in;
    logic   [NUM_BITS-1:0]  D_out;
    logic                   EOC;
    real                    V_target;

      modport DUT (input clk, rst_n, sample_rate, V_in, 
                                output D_out, EOC);

      modport TB (output rst_n, sample_rate, V_in, 
                                input clk, D_out, EOC);
endinterface //ADC