class ahb_sagent extends uvm_agent;

  ahb_drv drv;
  ahb_mon mon;

  `uvm_component_utils(ahb_sagent)
  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction  //new()


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = ahb_drv::type_id::create("drv", this);
    mon = ahb_mon::type_id::create("mon", this);
  endfunction
endclass
