class simple_monitor extends uvm_monitor;
  `uvm_component_utils(simple_monitor)
  virtual intf v_if;
  uvm_analysis_port#(logic) ap;
  logic out;
  function new(string name,uvm_component parent = parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap  = new("ap",this);
  endfunction
   
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     if(!(uvm_config_db#(virtual intf) :: get(this,"*","vif",v_if)))
      `uvm_error("","monitor virtual interface failed")
      else 
        `uvm_info("","connect phase env",UVM_LOW)
  endfunction
  
  task run_phase(uvm_phase phase);
     phase.raise_objection(this);
    `uvm_info("LABEL", "Finished run phase stated.", UVM_LOW);
    forever begin 
      @(v_if.clk);
      out = v_if.y;
      $display("in mon %d",v_if.y);
      ap.write(out);
    end
    `uvm_info("LABEL", "Finished run phase.", UVM_LOW);
   phase.drop_objection(this);
  endtask
     
endclass