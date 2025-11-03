import uvm_pkg::*;
`include "uvm_macros.svh"
// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "simple_env.sv"
module top;
   bit clk=0;
  simple_env env;
  intf inf(clk);bit f;
  and_gate a1(inf.a,inf.b,f);
  
  initial begin 
    env = new("env");
    uvm_config_db#(virtual intf) :: set(null,"*","vif",inf);
    run_test();
    $display("output %d",f);
  end
  always #5 clk = ~clk;
  initial #1000 $finish;
endmodule