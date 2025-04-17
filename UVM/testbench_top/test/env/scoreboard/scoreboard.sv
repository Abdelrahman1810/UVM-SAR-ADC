package scoreboard_pkg;
import agent_pkg::*;
import shared_pkg::*;
import sequenceItem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
`define create_obj(type, name) type::type_id::create(name, this);

class ADC_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(ADC_scoreboard)
    uvm_analysis_imp #(ADC_sequenceItem, ADC_scoreboard) scb_imp; // scoreboard export

    ADC_sequenceItem item;
    
    // error and correct counter
    int correct_counter = 0;
    int error_counter = 0;
    int numberOfTransactions = 0;

    function new(string name = "ADC_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_imp = new("scb_imp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

    function void write(ADC_sequenceItem t);
        item = t;
        numberOfTransactions++;
        Checking_task(item); 
    endfunction

    task Checking_task(ADC_sequenceItem chk_item);
        if (chk_item.EOC == chk_item.sample_sig) begin
            if ((int'(chk_item.V_target) == chk_item.D_out)) begin
                correct_counter++;
            end
        end else begin
            error_counter++;
        end
    endtask

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
        `uvm_info("report_phase", $sformatf("----- Total Number of transaction: %0d ", numberOfTransactions), UVM_LOW)
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
        `uvm_info("report_phase", $sformatf("----- Total correct transaction: %0d ", correct_counter), UVM_LOW)
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
        `uvm_info("report_phase", $sformatf("----- Total faild transaction: %0d ", error_counter), UVM_LOW)
        `uvm_info("report_phase", "------------------------------------------", UVM_LOW)
    endfunction
endclass
endpackage