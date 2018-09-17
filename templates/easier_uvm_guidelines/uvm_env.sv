`ifndef _{:UPPERNAME:}_ENV_SV
`define _{:UPPERNAME:}_ENV_SV

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_env
//
//------------------------------------------------------------------------------
class {:NAME:}_env_config extends uvm_object;
    // Control properties
    {:if:INITATOR_TARGET:}
    int unsigned num_initiator = 1;
    int unsigned num_target = 1;
    {:NAME:}_initiator_agent_config m_initiator_agent_config[];
    {:NAME:}_target_agent_config    m_target_agent_config[];
    {:endif:INITATOR_TARGET:}

    {:if:SINGLE_AGENT:}
    {:NAME:}_agent_config m_agent_config;
    {:endif:SINGLE_AGENT:}

    {:if:MULTI_AGENT:}
    int unsigned num_agents = 1;
    {:NAME:}_agent_config m_agent_config[];
    {:endif:MULTI_AGENT:}

    //function new(int unsigned num_initiator = 1, int unsigned num_target=1)
    //    this.num_initiator = num_initiator;
    //    this.num_target = num_target;
    //    m_initiator_agent_config = new(num_initiator);
    //    m_target_agent_config = new(num_target);
    //endfunction

endclass : {:NAME:}_env_config

//------------------------------------------------------------------------------
//
// CLASS: {:NAME:}_env
//
//------------------------------------------------------------------------------
class {:NAME:}_env extends uvm_env;
    // UVM Factory Registration Macro
    `uvm_component_utils({:NAME:}_env)

    {:NAME:}_env_config m_config;

    //------------------------------------------
    // Data Members
    //------------------------------------------

    //------------------------------------------
    // Sub components
    //------------------------------------------
    // Agent instance handles
    {:if:INITATOR_TARGET:}
    {:NAME:}_initator_agent m_initiator_agent[];
    {:NAME:}_target_agent m_target_agent[];
    {:endif:INITATOR_TARGET:}

    {:if:SINGLE_AGENT:}
    {:NAME:}_agent m_agent;
    {:endif:SINGLE_AGENT:}

    {:if:MULTI_AGENT:}
    {:NAME:}_agent m_agent[];
    {:endif:MULTI_AGENT:}

    // Virtual sequencer
    {:NAME:}_virtual_sequencer m_vsqr;


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
    {:if:INITATOR_TARGET:}
    m_initiator_agent = new[m_config.num_initiator];
    for (int i = 0; i < m_config.num_initiator; i++) begin
        $sformat(inst_name, "m_initiator_agent[%0d]", i);
        m_initiator_agent[i] = {:NAME:}_initiator_agent::type_id::create(inst_name, this);
        m_initiator_agent[i].m_config = m_config.m_initiator_agent_config[i];
    end

    m_target_agent = new[m_config.num_target];
    for (int i = 0; i < m_config.num_target; i++) begin
        $sformat(inst_name, "m_target_agent[%0d]", i);
        m_target_agent[i] = {:NAME:}_target_agent::type_id::create(inst_name, this);
        m_target_agent[i].m_config = m_config.m_target_agent_config[i];
    end
    {:endif:INITATOR_TARGET:}

    {:if:SINGLE_AGENT:}
    m_agent = {:NAME:}_agent::type_id::create("{:NAME:} agent",this);
    m_agent.m_config = this.m_agent_config;
    {:endif:SINGLE_AGENT:}

    {:if:MULTI_AGENT:}
    m_agent = new[m_config.num_agents];
    for (int i = 0; i < m_config.num_agents; i++) begin
        $sformat(inst_name, "m_initiator_agent[%0d]", i);
        m_agent[i] = {:NAME:}_agent::type_id::create(inst_name, this);
        m_agent[i].m_config = m_config.m_agent_config[i];
    end
    {:endif:MULTI_AGENT:}

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
