class simple_drv extends uvm_driver;
  `uvm_component_utils(simple_drv)
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
   forever begin
    @(vif.clk);
    vif.a <= vif.clk;
    vif.b <= vif.clk;
    $display("in driver a = %d b = %d y =%d",vif.a,vif.b,vif.y);
   end end
    `uvm_info("LABEL", "Finished run phase.", UVM_LOW);
   phase.drop_objection(this);
  endtask
endclass