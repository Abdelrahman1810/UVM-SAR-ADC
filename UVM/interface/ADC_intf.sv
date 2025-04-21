interface ADC_intf #(
    parameter NUM_BITS = 4
) (
    input clk
);
    logic                   rst_n;          // input
    logic   [1:0]           sample_rate;    // input
    real                    V_in;           // input

    logic   [NUM_BITS-1:0]  D_out;          // output
    logic                   EOC;            // output
    
    real                    V_target;       // internal signal

    modport DUT (
        input clk, rst_n, sample_rate, V_in, 
        output D_out, EOC
    );
endinterface //ADC