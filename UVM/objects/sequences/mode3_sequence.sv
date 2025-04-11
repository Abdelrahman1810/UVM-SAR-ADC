package mode3_seq_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequenceItem_pkg::*;
import shared_pkg::*;
class mode3_sequence extends uvm_sequence #(ADC_sequenceItem);
    `uvm_object_utils(mode3_sequence)
    function new(string name = "mode3_sequence");
        super.new(name);
    endfunction //new()

    ADC_sequenceItem item;

    task body();
        repeat(MODE3_LOOP) begin
            item = ADC_sequenceItem::type_id::create("item");
            start_item(item);
            item.c_sample_rate_M1.constraint_mode(0);
            item.c_sample_rate_M2.constraint_mode(0);
            item.c_sample_rate_M3.constraint_mode(1);
            item.c_sample_rate_M4.constraint_mode(0);
            assert (item.randomize());
            finish_item(item);
        end
    endtask

endclass //mode3_sequence extends superClass
endpackage