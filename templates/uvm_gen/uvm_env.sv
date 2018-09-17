`ifndef _{:UPPERNAME:}_ENV_SV
`define _{:UPPERNAME:}_ENV_SV

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_env
//
//------------------------------------------------------------------------------
class {:NAME:}_env_config extends uvm_object;
    // The following two bits are used to control whether checks and coverage are
    // done both in the bus monitor class and the interface
    bit intfChecksEnable = 1;
    bit intfCoverageEnable = 1;
    bit hasBusMonitor = 1;

    // Control properties
    int unsigned numMasters = 1;
    int unsigned numSlaves = 1;
    {:NAME:}_agent_config m_agent_config;

endclass : {:NAME:}_env_config

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_env
//
//------------------------------------------------------------------------------
class {:NAME:}_env extends uvm_env;

    protected virtual interface {:NAME:}_if vif;

    {:NAME:}_env_config m_config;

    //------------------------------------------
    // Data Members
    //------------------------------------------

    //------------------------------------------
    // Sub components
    //------------------------------------------
    // Agent instance handles
    {:AGENT1:} m_{:AGENT1:}[];
    {:AGENT2:} m_{:AGENT2:}[];

    // Virtual sequencer
    <VSQR> m_vsqr;

    // UVM Factory Registration Macro
    `uvm_component_utils({:NAME:}_env)

    {:if:REG1:}
    // Register blocks
    {:REG1:}_ral {:REG1:}regmodel;
    {:endif:REG1:}

    //------------------------------------------
    // Methods
    //------------------------------------------
    extern function new (string name="{:NAME:}_env", uvm_component parent=null);
    extern function void end_of_elaboration_phase (uvm_phase _phase);
    extern function void build_phase (uvm_phase _phase);
    extern function void connect_phase (uvm_phase phase);

endclass : {:NAME:}_env

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
function {:NAME:}_env::new (string name="{:NAME:}_env", uvm_component parent=null);
    super.new(name, parent);
endfunction: new

//------------------------------------------------------------------------------
function void {:NAME:}_env::end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction

//------------------------------------------------------------------------------
function void {:NAME:}_env::build_phase (uvm_phase phase);

    string inst_name;
    // super.build(phase);

    // Configure
    if(!uvm_config_db #({:NAME:}_env_config)::get(this, "", "m_env_config", m_config)) begin
        `uvm_error("build_phase", "Unable to find {:NAME:}_env_config (m_config) in uvm_config_db")
    end

    // Create
    m_{:AGENT1:} = new[m_config.numMasters];
    for (int i = 0; i < m_config.numMasters; i++) begin
        $sformat(inst_name, "m{:AGENT1:}[%0d]", i);
        m_{:AGENT1:}[i] = {:AGENT1:}::type_id::create(inst_name, this);
    end

    m_{:AGENT2:} = new[m_config.numSlaves];
    for (int i = 0; i < m_config.numSlaves; i++) begin
        $sformat(inst_name, "m{:AGENT2:}[%0d]", i);
        m_{:AGENT2:}[i] = {:AGENT2:}::type_id::create(inst_name, this);
    end

    {:if:REG1:}
    // Create and build register blocks
    regmodel = {:REG1:}_ral::type_id::create("{:REG1:}_ral", this);
    regmodel.build();
    {:endif:REG1:}

    `uvm_info("build_phase", $sformatf("%s built", get_full_name()))

endfunction

//------------------------------------------------------------------------------
function void {:NAME:}_env::connect_phase (uvm_phase phase);
    // Connectivity if any

    {:if:REG1:}
    if (m_serial_reg_model.get_parent() == null) begin

        // Create register to IO adapters
        {:ADAPTOR1:}_adapter m_{:ADAPTOR1:} = {:ADAPTOR1:}_adapter::type_id::create("m_{:ADAPTOR1:}",,get_full_name());

        // Add the adapter to the register model
        m_serial_reg_model.default_map.set_sequencer(m_{:AGENT1:}_agent.m_sequencer, m_{:ADAPTOR1:});

        // Set the base address in the system
        m_{:REG1:}_reg_model.default_map.set_base_addr({:BASE1:});

    end
    {:endif:REG1:}

endfunction

`endif
