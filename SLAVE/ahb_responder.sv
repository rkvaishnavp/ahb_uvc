class ahb_responder extends uvm_driver #(ahb_tx);
  virtual ahb_intf vif;
  virtual arb_intf arb_vif;
  `uvm_component_utils_begin(ahb_responder)
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
    //respond to the requests coming from master driver
    forever begin
      @(posedge arb_vif.hclk);
      if (arb_vif.hbusreq[0] == 1) begin
        arb_vif.hgrant[0] = 1;
      end else begin
        arb_vif.hgrant[1] = 1;
      end
    end
  endtask
endclass


