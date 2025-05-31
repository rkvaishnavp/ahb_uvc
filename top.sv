`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "ahb_tx.sv"
`include "ahb_seq_lib.sv"
`include "ahb_sqr.sv"
`include "ahb_drv.sv"
`include "ahb_mon.sv"
`include "ahb_cov.sv"
`include "ahb_magent.sv"
`include "ahb_sagent.sv"
`include "ahb_env.sv"
`include "test_lib.sv"
module top;

  initial begin
    run_test("ahb_base_test");
  end
endmodule
