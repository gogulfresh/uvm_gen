package {:NAME:}_pkg;
    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "./{:NAME:}_seq_item.sv"
    `include "./{:NAME:}_sequencer.sv"
    `include "./{:NAME:}_monitor.sv"
    `include "./{:NAME:}_driver.sv"
    `include "./{:NAME:}_agent.sv"
    `include "./{:NAME:}_env.sv"

endpackage
