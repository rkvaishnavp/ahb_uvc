class ahb_env extends uvm_env;

  ahb_magent magent;
  ahb_sagent sagent;
  `uvm_component_utils(ahb_env)
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    magent = ahb_magent::type_id::create("magent", this);
    sagent = ahb_sagent::type_id::create("apb_sagent_i", this);
  endfunction
endclass
