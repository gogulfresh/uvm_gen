`ifndef _{:UPPERNAME:}_SCOREBOARD_SV_
`define _{:UPPERNAME:}_SCOREBOARD_SV_

class {:NAME:}_scoreboard extends uvm_scoreboard;

    `uvm_component_utils({:NAME:}_scoreboard)

    // Attributes

    // Methods
    extern function new (string name="{:NAME:}_scoreboard", uvm_component parent=null);
    extern function void build_phase (uvm_phase phase);
    extern function void connect_phase (uvm_phase phase);
    extern task run_phase (uvm_phase phase);
    extern function void start_of_simulation_phase (uvm_phase phase);
    extern function void report_phase (uvm_phase phase);
endclass: {:NAME:}_scoreboard

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
function {:NAME:}_scoreboard::new (string name="{:NAME:}_scoreboard", uvm_component parent=null);
    super.new(name, parent);
endfunction: new

function void {:NAME:}_scoreboard::build_phase (uvm_phase phase);
endfunction

function void {:NAME:}_scoreboard::connect_phase (uvm_phase phase);
endfunction

task {:NAME:}_scoreboard::run_phase (uvm_phase phase);
endtask: run_phase

//------------------------------------------------------------------------------
// Print configuration
//
function void {:NAME:}_scoreboard::start_of_simulation_phase (uvm_phase phase);
endfunction

function void {:NAME:}_scoreboard::report_phase (uvm_phase phase);
endfunction

`endif
