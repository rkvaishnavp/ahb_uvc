class ahb_drv extends uvm_driver #(ahb_tx);

  virtual ahb_intf vif;
  `uvm_component_utils(ahb_drv)
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual ahb_intf)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NO VIF", "Virtual Interface not Found in Driver")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      req.print();
      seq_item_port.item_done();
    end
  endtask

endclass
