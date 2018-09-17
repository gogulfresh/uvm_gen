`ifndef _{:UPPERNAME:}_AGENT_SV_
`define _{:UPPERNAME:}_AGENT_SV_

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_agent
//
//------------------------------------------------------------------------------

class {:NAME:}_agent_config #(type VIF_TYPE = virtual {:NAME:}_if) extends uvm_object;

    VIF_TYPE vif;
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    bit coverage_enable;
    bit integration_coverage_enable;
    bit checks_enable;

    function new(string name = "");
        super.new(name);
    endfunction

endclass

class {:NAME:}_agent #(type VIF_TYPE = virtual {:NAME:}_if) extends uvm_agent;

    //------------------------------------------
    // Data Members
    //------------------------------------------
    {:NAME:}_agent_config #(VIF_TYPE) m_config;
    static string MSGID = "/{:COMPANY:}/{:PROJECT:}/{:NAME:}_agent";

    `uvm_component_utils({:NAME:}_agent)

    //------------------------------------------
    // Component Members
    //------------------------------------------
    uvm_analysis_port #({:TRANSACTION:}) a_port;

    {:NAME:}_sequencer                      m_sequencer;
    {:NAME:}_monitor   #(VIF_TYPE)          m_monitor;
    {:NAME:}_driver    #(VIF_TYPE)          m_driver;
    {:NAME:}_coverage                       m_coverage;

    //------------------------------------------
    // Methods
    //------------------------------------------
    // Standard Methods
    extern function new (string name = "{:NAME:}_agent", uvm_component parent = null);
    extern function void build_phase (uvm_phase phase);
    extern function void connect_phase (uvm_phase phase);

endclass: {:NAME:}_agent

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
// Constructor
function {:NAME:}_agent::new (string name = "{:NAME:}_agent", uvm_component parent = null);
    super.new(name, parent);
endfunction

//------------------------------------------------------------------------------
// Construct sub-components
// retrieve and set sub-component configuration
//
function void {:NAME:}_agent::build_phase (uvm_phase phase);
    super.build_phase(phase);
    this.a_port = new("a_port", this);
    if(m_config==null) begin
        //In case agent is in env, we do set m_config top down. If it used stand alone we use configdb
        if(!uvm_config_db #({:NAME:}_agent_config)::get(this, "{:NAME:}_agent_config", m_config))begin
            `uvm_error(get_type_name(),{MSGID,"Failed to get agent's config object: {:NAME:}_agent_config"})
        end
    end
    // Monitor is always present
    m_monitor = {:NAME:}_monitor#(VIF_TYPE)::type_id::create("m_monitor", this);
    // Only build the driver and sequencer if active
    if(m_config.is_active == UVM_ACTIVE)begin
        m_sequencer = {:NAME:}_sequencer::type_id::create("m_sequencer", this);
        m_driver    = {:NAME:}_driver#(VIF_TYPE)::type_id::create("m_driver", this);
    end
    if(m_config.coverage_enable)begin
        m_coverage = {:NAME:}_coverage::type_id::create("m_coverage", this);
    end
endfunction: build_phase

//------------------------------------------------------------------------------
// Connect sub-components
//
function void {:NAME:}_agent::connect_phase (uvm_phase phase);
    m_monitor.vif = m_config.vif;
    a_port = m_monitor.a_port;
    // Only connect the driver and the sequencer if active
    if(m_config.is_active == UVM_ACTIVE) begin
        m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        m_driver.vif = m_config.vif;
    end
    if(m_config.coverage_enable) begin
        m_monitor.a_port.connect(m_coverage.analysis_export);
    end
endfunction: connect_phase

`endif
