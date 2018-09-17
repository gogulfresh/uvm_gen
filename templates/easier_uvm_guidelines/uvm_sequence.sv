`ifndef _{:UPPERNAME:}_SEQUENCE_SV_
`define _{:UPPERNAME:}_SEQUENCE_SV_

class {:NAME:}_sequence extends uvm_sequence #({:TRANSACTION:});

    `uvm_sequence_utils({:NAME:}_sequence)

    // Attributes
    /*NONE*/

    // Methods
    extern function new (string name="{:NAME:}_sequence");

    extern function void do_record(uvm_recorder recorder);
    extern task body;

endclass: {:NAME:}_sequence

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
function {:NAME:}_sequence::new (string name="{:NAME:}_sequence");
    super.new(name);
endfunction

task {:NAME:}_sequence::body;

    //`uvm_do(req)
    {:TRANSACTION:} req = {:TRANSACTION:}::type_id::create("orig_req");

    start_item(req); // wait for request from driver

    if (!req.randomize()) begin // late "just-in-time" randomization
        `uvm_error("body", "randomization failure for req") // an error can be overridden
    end

    finish_item(req); // send the data

    `uvm_info("SEQ", req.convert2string(), UVM_DEBUG)

endtask

function void {:NAME:}_sequence::do_record(uvm_recorder recorder);
    //just needed if the sequence has additional attributes
    super.do_record(recorder);
endfunction

`endif
