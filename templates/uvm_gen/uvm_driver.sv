`ifndef _{:UPPERNAME:}_DRIVER_SV_
`define _{:UPPERNAME:}_DRIVER_SV_


////////////////////////////////////////////////////////////////////////////////
// Class Description
////////////////////////////////////////////////////////////////////////////////
class {:NAME:}_driver #(type VIF_TYPE = virtual {:NAME:}_if) extends uvm_driver #({:TRANSACTION:});


    `uvm_component_utils({:NAME:}_driver)

    // Attributes
    VIF_TYPE vif;

    // Methods
    extern function new (string name="{:NAME:}_driver", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase (uvm_phase phase);
    extern task drive_item({:TRANSACTION:} item);
    extern task reset_signals({:TRANSACTION:} item);

endclass : {:NAME:}_driver

////////////////////////////////////////////////////////////////////////////////
// Implementation
//
//------------------------------------------------------------------------------
// Constructor
//
function {:NAME:}_driver::new(string name="{:NAME:}_driver", uvm_component parent=null);
    super.new(name, parent);
endfunction : new

//------------------------------------------------------------------------------
// Build
//
function void {:NAME:}_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    //if (!(uvm_config_db #({:NAME:}Cfg)::get(this, "", "mCfg", mCfg))) begin
    //    `uvm_fatal("CONFIG_LOAD", {get_full_name(), ".mCfg get failed!!!"})
    //end

    //if (!uvm_config_db#(virtual {:NAME:}If)::get(this, "", "{:NAME:}Vif", this.vif)) begin
    //    `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    //end
endfunction : build_phase

//------------------------------------------------------------------------------
// Get and process items
//
task {:NAME:}_driver::run_phase(uvm_phase phase);
    reset_signals();
    forever begin
        // Get the next data item from sequencer
        seq_item_port.get_next_item(req);
        phase.raise_objection(this);
        // Execute the item
        this.drive_item(req);

    `ifdef USING_RESPONSE
        rsp.set_id_info(req);
        // response
        // seq_item_port.item_done(rsp);
        seq_item_port.put_response(rsp);
    `else
        // consume the request
        seq_item_port.item_done();
    `endif
        phase.drop_objection(this);
    end
endtask : run_phase

//------------------------------------------------------------------------------
// Drive sequence item
//
task {:NAME:}_driver::reset_signals({:TRANSACTION:} item);
    // Add your logic here
endtask : reset_signals 

task {:NAME:}_driver::drive_item({:TRANSACTION:} item);
    // Add your logic here
endtask : drive_item

`endif
