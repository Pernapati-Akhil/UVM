`include "simple_agent.sv"
`include "simple_scoreboard.sv"
class simple_env extends uvm_env;
  `uvm_component_utils(simple_env)
  virtual intf vif;
  simple_agent agt;
  simple_score_board scb;
  
  function new(string name,uvm_component parent = parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = simple_agent :: type_id :: create("agt",this);
    scb = simple_score_board :: type_id :: create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap.connect(scb.sap);
  endfunction
  
 
endclass