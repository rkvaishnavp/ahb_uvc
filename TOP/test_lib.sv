//define a test
class ahb_base_test extends uvm_test;
  ahb_env env;
  `uvm_component_utils(ahb_base_test)
  `NEW_COMP
  function void build_phase(uvm_phase phase);
    `uvm_info("AHB_UVC", "Test: Build_phase", UVM_NONE)
    env = ahb_env::type_id::create("env", this);
    uvm_config_db#(int)::set(this, "env.magent.*", "master_slave_f", 1);
    uvm_config_db#(int)::set(this, "env.sagent.*", "master_slave_f", 0);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("TB HIERARCHY", this.sprint(), UVM_NONE)
  endfunction
endclass

class ahb_wr_rd_test extends ahb_base_test;
  `uvm_component_utils(ahb_wr_rd_test)
  `NEW_COMP
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    ahb_wr_rd_seq wr_rd_seq;
    wr_rd_seq = ahb_wr_rd_seq::type_id::create("wr_rd_seq");
    phase.phase_done.set_drain_time(this, 100);
    phase.raise_objection(this);
    wr_rd_seq.start(env.magent.sqr);
    phase.drop_objection(this);
  endtask
endclass
