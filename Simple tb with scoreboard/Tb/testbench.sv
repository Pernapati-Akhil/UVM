import uvm_pkg::*;
`include "uvm_macros.svh"
// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "simple_env.sv"
module top;
   bit clk=0;
  simple_env env;
  intf inf(clk);
  and_gate a1(inf.a,inf.b,inf.y);
  
  initial begin 
    env = new("env");
    uvm_config_db#(virtual intf) :: set(null,"*","vif",inf);
    run_test();
    $display("output %d",inf.y);
  end
   initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    //$dumpfile("dump.vcd");
    //$dumpvars;
    #50 $finish;
  end 
  
  always #5 clk = ~clk;
  initial #50 $finish;
endmodule