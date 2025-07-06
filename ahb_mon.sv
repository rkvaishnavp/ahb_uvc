class ahb_mon extends uvm_monitor;

  uvm_analysis_port #(ahb_tx) ap_port;
  virtual ahb_intf vif;
  `uvm_component_utils(ahb_mon)
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_port = new("ap_port", this);
    if (!uvm_resource_db#(virtual ahb_intf)::read_by_type("AHB", vif, this)) begin
      `uvm_fatal("NO VIF", "Virtual Interface not Found in Driver")
    end
  endfunction

  task run_phase(uvm_phase phase);
  endtask

endclass
