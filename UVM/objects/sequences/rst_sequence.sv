package rst_seq_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequenceItem_pkg::*;
import shared_pkg::*;
class rst_sequence extends uvm_sequence #(ADC_sequenceItem);
    `uvm_object_utils(rst_sequence)
    function new(string name = "rst_sequence");
        super.new(name);
    endfunction //new()

    ADC_sequenceItem item;

    task body();
        repeat(RESET_LOOP) begin
            item = ADC_sequenceItem::type_id::create("item");
            start_item(item);
            item.Reset();
            finish_item(item);
        end
    endtask

endclass //rst_sequence extends superClass
endpackage