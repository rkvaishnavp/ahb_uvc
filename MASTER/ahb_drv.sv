class ahb_drv extends uvm_driver #(ahb_tx);
  virtual ahb_intf vif;
  virtual arb_intf arb_vif;
  `uvm_component_utils_begin(ahb_drv)
  `uvm_component_utils_end
  `NEW_COMP

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_resource_db#(virtual ahb_intf)::read_by_type("AHB", vif, this)) begin
      `uvm_error("RESOURCE_DB_ERROR", "Not able to retrive ahb_vif handle from resource_db")
    end
    if (!uvm_resource_db#(virtual arb_intf)::read_by_type("AHB", arb_vif, this)) begin
      `uvm_error("RESOURCE_DB_ERROR", "Not able to retrive arb_vif handle from resource_db")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      req.print();
      drive_tx(req);
      seq_item_port.item_done();  //I am done with this item
    end
  endtask

  task drive_tx(ahb_tx req);
    arb_phase(req);
    addr_phase(req);
    #10;
    for (int i = 0; i < req.len - 1; i = i + 1) begin
      fork
        #10;
        addr_phase(req);
        data_phase(req);
      join
    end
    data_phase(req);
  endtask

  task arb_phase(ahb_tx req);
    `uvm_info("AHB_TX", "arb_phase", UVM_LOW)
    @(posedge arb_vif.hclk);
    arb_vif.hbusreq[req.master] = 1;
    arb_vif.hlock[req.master]   = req.mastlock;
    wait (arb_vif.hgrant[req.master] == 1);
    arb_vif.hmaster   = req.master;
    arb_vif.hmastlock = req.mastlock;
  endtask

  task addr_phase(ahb_tx req);
    `uvm_info("AHB_TX", "addr_phase", UVM_LOW)
  endtask

  task data_phase(ahb_tx req);
    `uvm_info("AHB_TX", "data_phase", UVM_LOW)
  endtask
endclass

