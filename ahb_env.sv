class ahb_env extends uvm_env;

  ahb_magent ahb_magent_i;
  ahb_sagent ahb_sagent_i;
  `uvm_component_utils(ahb_env)
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_magent_i = ahb_magent::type_id::create("ahb_magent_i", this);
    ahb_sagent_i = ahb_sagent::type_id::create("apb_sagent_i", this);
  endfunction
endclass
