class ahb_cov extends uvm_subscriber #(ahb_tx);

  ahb_tx tx;
  event  ahb_e;
  `uvm_component_utils(ahb_cov)

  covergroup ahb_cg @(ahb_e);
    coverpoint tx.wr_rd;
  endgroup

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
    ahb_cg = new();
  endfunction

  virtual function void write(T t);
    $cast(tx, t);
    ahb_cg.sample();
  endfunction

endclass
