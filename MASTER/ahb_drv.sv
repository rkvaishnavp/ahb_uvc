class ahb_drv extends uvm_driver#(ahb_tx);
virtual ahb_intf vif;
`uvm_component_utils_begin(ahb_drv)
`uvm_component_utils_end
`NEW_COMP

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if (!uvm_resource_db#(virtual ahb_intf)::read_by_type("AHB", vif, this)) begin
	`uvm_error("RESOURCE_DB_ERROR", "Not able to retrive ahb_vif handle from resource_db")
end
endfunction

task run_phase(uvm_phase phase);
	forever begin
		seq_item_port.get_next_item(req);
		req.print();
		seq_item_port.item_done();  //I am done with this item
	end
endtask
endclass

