class ahb_tx extends uvm_sequence_item;
  rand bit     [31:0] addr;
  rand bit     [31:0] dataQ           [$];
  rand bit            wr_rd;
  rand burst_t        burst;
  rand bit     [ 2:0] size;
  rand bit     [ 4:0] len;
  rand bit     [ 6:0] prot;
  rand bit            excl;
  rand bit     [ 3:0] master;
  rand bit            nonsec;
  rand bit            mastlock;
  bit          [ 1:0] resp;
  bit                 exokay;

  integer             txsize;
  bit          [31:0] lower_wrap_addr;
  bit          [31:0] upper_wrap_addr;

  `uvm_object_utils_begin(ahb_tx)
    `uvm_field_int(addr, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_queue_int(dataQ, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(wr_rd, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_enum(burst_t, burst, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(size, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(len, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(prot, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(excl, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(master, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(nonsec, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(mastlock, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(resp, UVM_ALL_ON | UVM_NOPACK)
    `uvm_field_int(exokay, UVM_ALL_ON | UVM_NOPACK)
  `uvm_object_utils_end
  `NEW_OBJ

  constraint burst_len_c {
    (burst == SINGLE) -> (len == 1);
    (burst inside {INCR4, WRAP4}) -> (len == 4);
    (burst inside {INCR8, WRAP8}) -> (len == 8);
    (burst inside {INCR16, WRAP16}) -> (len == 16);
    len inside {[1 : 16]};
  }

  constraint dataQ_c {dataQ.size() == len;}

  constraint aligned_c {addr % (2 ** size) == 0;}

  constraint burst_c {soft burst == INCR4;}

  constraint size_c {soft size_c == 2;}

  constraint master_c {soft master == 0;}

  function void post_randomize();
    calc_wrap_boundaries();
  endfunction

  function void calc_wrap_boundaries();
    txsize = len * (2 ** size);
    lower_wrap_addr = addr - (addr % txsize);
    upper_wrap_addr = lower_wrap_addr + (txsize - 1);
  endfunction
endclass
