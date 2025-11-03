`include "simple_drv.sv"
`include "simple_monitor.sv"
class simple_agent extends uvm_agent;
  `uvm_component_utils(simple_agent)
  
  simple_drv drv;
  simple_monitor mon;
  function new(string name,uvm_component parent = parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = simple_drv :: type_id :: create("drv",this);
    mon = simple_monitor :: type_id :: create("mon",this);
  endfunction
        
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
 
endclass