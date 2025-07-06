class ahb_drv extends uvm_driver #(ahb_tx);

  bit master_slave_f;
  virtual ahb_intf vif;
  `uvm_component_utils_begin(ahb_drv)
    `uvm_field_int(master_slave_f, UVM_ALL_ON)
  `uvm_component_utils_end
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_resource_db#(virtual ahb_intf)::read_by_type("AHB", vif, this)) begin
      `uvm_fatal("NO VIF", "Virtual Interface not Found in Driver")
    end
  endfunction

  task run_phase(uvm_phase phase);
    if (master_slave_f == 1) begin
      forever begin
        seq_item_port.get_next_item(req);
        req.print();
        seq_item_port.item_done();
      end
    end else begin
      `uvm_info("AHB_DRIVER", "Driver Behaving like slave", UVM_NONE)
    end
  endtask

endclass
