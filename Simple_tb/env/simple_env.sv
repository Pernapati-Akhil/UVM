class simple_env extends uvm_env;
  `uvm_component_utils(simple_env)
  virtual intf vif;
  
  function new(string name,uvm_component parent = parent);
    super.new(name,parent);
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(!(uvm_config_db#(virtual intf) :: get(this,"*","vif",vif)))
           `uvm_error("","driver virtual interface failed")
      else 
        `uvm_info("","connect phase env",UVM_LOW)
  endfunction
  
  task run_phase(uvm_phase phase);
     phase.raise_objection(this);
    `uvm_info("LABEL", "Finished run phase stated.", UVM_LOW);
    begin 
      `uvm_info("","run phase env",UVM_LOW)
    $display("%d",vif.clk);
   forever begin
      @(vif.clk)
    vif.a <= ~vif.clk;
    vif.b <= vif.clk;
     $display("in env %d %d %d",vif.a,vif.b,vif.clk);
   end end
    `uvm_info("LABEL", "Finished run phase.", UVM_LOW);
   phase.drop_objection(this);
  endtask
endclass