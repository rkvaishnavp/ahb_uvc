`include "uvm_pkg.sv"
import uvm_pkg::*;  //everything of uvm_pkg becomes part of my TB now
`include "ahb_common.sv"
`include "ahb_intf.sv"
`include "ahb_tx.sv"
`include "ahb_seq_lib.sv"
`include "ahb_sqr.sv"
`include "ahb_drv.sv"
`include "ahb_responder.sv"
`include "ahb_mon.sv"
`include "ahb_cov.sv"
`include "ahb_magent.sv"
`include "ahb_sagent.sv"
`include "ahb_env.sv"
module top;
  reg clk, rst;
  integer count;
  ahb_intf pif (
      clk,
      rst
  );
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst = 1;
    #20;
    rst = 0;
  end
  `include "test_lib.sv"
  initial begin
    run_test("ahb_base_test");
  end
  initial begin
    $value$plusargs("count=%d", count);
    uvm_resource_db#(virtual ahb_intf)::set("AHB", "VIF", pif,
                                            null);  //now pif will accessible everywhere in TB
  end
endmodule
