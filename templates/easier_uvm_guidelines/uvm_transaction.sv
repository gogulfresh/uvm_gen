`ifndef _{:UPPERNAME:}_SEQ_ITEM_SV_
`define _{:UPPERNAME:}_SEQ_ITEM_SV_

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_seq_item
//
//------------------------------------------------------------------------------


class {:NAME:}_seq_item extends uvm_sequence_item;
    `uvm_object_utils({:NAME:}_seq_item)

    //------------------------------------------
    // Data Members
    //------------------------------------------
    // Request data attributes
    rand {:TYPE1:} {:IDENTIFIER1:};

    // Constraint attributes
    constraint {:CONSTRAINT1:} {

    }

    //------------------------------------------
    // Methods
    //------------------------------------------
    extern function new(string name="{:NAME:}_seq_item");
    extern function void   do_copy (uvm_object rhs);
    extern function bit    do_compare (uvm_object rhs, uvm_comparer comparer);
    extern function string convert2string ();
    extern function void   do_print (uvm_printer printer);
    extern function void   do_pack (uvm_packer packer);
    extern function void   do_unpack (uvm_packer packer);
    extern function void   do_record (uvm_recorder recorder);

endclass : {:NAME:}_seq_item

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
function {:NAME:}_seq_item::new(string name="{:NAME:}_seq_item");
    super.new(name);
endfunction : new

function void {:NAME:}_seq_item::do_copy(uvm_object rhs);
endfunction

function bit {:NAME:}_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
endfunction

function string {:NAME:}_seq_item::convert2string();
endfunction

function void {:NAME:}_seq_item::do_print(uvm_printer printer);
endfunction

function void {:NAME:}_seq_item::do_pack(uvm_packer packer);
endfunction

function void {:NAME:}_seq_item::do_unpack(uvm_packer packer);
endfunction

function void {:NAME:}_seq_item::do_record(uvm_recorder recorder);
endfunction



`endif
