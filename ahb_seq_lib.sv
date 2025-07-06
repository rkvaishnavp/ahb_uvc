class ahb_base_seq extends uvm_sequence #(ahb_tx);

  `uvm_object_utils(ahb_base_seq)
  function new(string name = "");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase = get_starting_phase();
    if (phase != null) begin
      $display("Raising Objection");
      phase.phase_done.set_drain_time(this, 100);
      phase.raise_objection(this);
    end
  endtask

  task post_body();
    uvm_phase phase = get_starting_phase();
    if (phase != null) begin
      $display("Dropping Objection");
      phase.drop_objection(this);
    end
  endtask

endclass

class ahb_wr_rd_seq extends ahb_base_seq;

  `uvm_object_utils(ahb_wr_rd_seq)
  function new(string name = "");
    super.new(name);
  endfunction

  task body();
    repeat (1) `uvm_do_with(req, {req.wr_rd == 1;})
    repeat (1) `uvm_do_with(req, {req.wr_rd == 0;})
  endtask

endclass
