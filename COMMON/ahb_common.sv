typedef enum bit [2:0] {
  SINGLE = 3'b000,
  INCR   = 3'b001,
  WRAP4  = 3'b010,
  INCR4  = 3'b011,
  WRAP8  = 3'b100,
  INCR8  = 3'b101,
  WRAP16 = 3'b110,
  INCR16 = 3'b111
} burst_t;

`define NEW_COMP \
function new(string name, uvm_component parent); \
	super.new(name, parent); \
endfunction \

`define NEW_OBJ \
function new(string name=""); \
	super.new(name); \
endfunction \

