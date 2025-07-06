class ahb_tx extends uvm_sequence_item;
  rand bit [31:0] addr;
  rand bit [31:0] dataQ[$];
  rand bit wr_rd;
  rand burst_t burst;
  rand bit [4:0] len;

  `uvm_object_utils_begin(ahb_tx)
    `uvm_field_int(addr, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_queue_int(dataQ, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(wr_rd, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_enum(burst_t, burst, UVM_ALL_ON | UVM_NOPACK)
  `uvm_object_utils_end
  function new(string name = "");
    super.new(name);
  endfunction

  constraint burst_len_c {
    (burst == SINGLE) -> (len == 1);
    (burst inside {INCR4, WRAP4}) -> (len == 4);
    (burst inside {INCR8, WRAP8}) -> (len == 8);
    (burst inside {INCR16, WRAP16}) -> (len == 16);
    len inside {[1 : 16]};  //taking care of INCR burst
  }

  constraint dataQ_c {dataQ.size() == len;}
endclass
