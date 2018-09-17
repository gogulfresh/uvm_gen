`ifndef _{:UPPERNAME:}_MONITOR_SV_
`define _{:UPPERNAME:}_MONITOR_SV_

//------------------------------------------
// Class Description
//------------------------------------------
class {:NAME:}_monitor #(type VIF_TYPE = virtual {:NAME:}_if) extends uvm_monitor;

    // Attributes
    VIF_TYPE vif;
    uvm_analysis_port #({:TRANSACTION:}) a_port;
    //{:NAME:}_config     m_config;

    protected {:TRANSACTION:} tr;
    event covTransaction;

    covergroup covTrans @covTransaction;
    endgroup : covTrans

    `uvm_component_utils({:NAME:}_monitor#(VIF_TYPE))

    ////////////////////////////////////////////////////////////////////////////////
    // Implementation
    //------------------------------------------------------------------------------
    function new(string name="{:LOWERNAME:}_monitor", uvm_component parent=null);
        super.new(name, parent);
        this.a_port = new("a_port", this);
    endfunction: new

    function build_phase(uvm_phase phase);
        super.build_phase(phase);

        //if (!(uvm_config_db#(virtual {:NAME:}If)::get(this, "", "{:NAME:}Vif", vif))) begin
        //    `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        //end

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        this.collect_transactions(phase); // collector task
    endtask: run_phase

    task collect_transactions(uvm_phase phase);
        forever begin
            this.tr = {:TRANSACTION:}::type_id::create("tr");
            phase.raise_objection(this);

            this.BusToTransaction();
            this.a_port.write(tr);

            phase.drop_objection(this);
        end
    endtask : collect_transactions

    function void BusToTransaction();
    endfunction : BusToTransaction

endclass: {:NAME:}_monitor

`endif
