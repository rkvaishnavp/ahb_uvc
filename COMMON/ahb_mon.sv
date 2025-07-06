class ahb_mon extends uvm_monitor;
uvm_analysis_port#(ahb_tx) ap_port;
virtual ahb_intf vif;
`uvm_component_utils(ahb_mon)
`NEW_COMP

function void build_phase(uvm_phase phase);
super.build_phase(phase);
ap_port = new("ap_port", this);
if (!uvm_resource_db#(virtual ahb_intf)::read_by_type("AHB", vif, this)) begin
	`uvm_error("RESOURCE_DB_ERROR", "Not able to retrive ahb_vif handle from resource_db")
end
endfunction

task run_phase(uvm_phase phase);
endtask
endclass
