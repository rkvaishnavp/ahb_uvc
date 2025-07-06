vlog +incdir+C:/Users/itsme/Desktop/ahb_uvc +incdir+C:/Users/itsme/Desktop/uvm-1.2/src top.sv

vsim top -sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi +UVM_TESTNAME=ahb_wr_rd_test +UVM_TIMEOUT=5000000 +UVM_VERBOSITY=UVM_MEDIUM -vopt -l run.log

#do wave.do
run -all
