class simple_score_board extends uvm_scoreboard;
  `uvm_component_utils(simple_score_board)
  virtual intf vif;
  logic b[$];
  uvm_analysis_imp#(logic,simple_score_board) sap;
  
  function new(string name,uvm_component parent = parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sap  = new("ap",this);
  endfunction
  
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(!(uvm_config_db#(virtual intf) :: get(this,"*","vif",vif)))
           `uvm_error("","driver virtual interface failed")
      else 
        `uvm_info("","connect phase env",UVM_LOW)
  endfunction
        
  function void write(logic a);
    b.push_back(a);
    $display("value = %d %p",a,b);
  endfunction 
    
  task run_phase(uvm_phase phase);
     phase.raise_objection(this);
    `uvm_info("LABEL", "Finished run phase stated.", UVM_LOW);
    forever begin 
      @(vif.clk);
      `uvm_info("",$sformatf("Test at clk %d %d %p",vif.a,vif.b,b),UVM_LOW)
      if(b.pop_front === vif.a & vif.b)
        `uvm_info("","Test pass",UVM_LOW)
      else
        `uvm_info("",$sformatf("Test Fail %d %d %p",vif.a,vif.b,b),UVM_LOW)
  
    end 
    `uvm_info("LABEL", "Finished run phase.", UVM_LOW);
   phase.drop_objection(this);
  endtask
endclass