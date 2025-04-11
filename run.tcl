vlib work

# vlog {michaelehab_AES-Verilog/addRoundKey.v}
# vlog {michaelehab_AES-Verilog/AES.v}
# vlog {michaelehab_AES-Verilog/AES_Encrypt.v}
# vlog {michaelehab_AES-Verilog/decryptRound.v}
# vlog {michaelehab_AES-Verilog/encryptRound.v}
# vlog {michaelehab_AES-Verilog/inverseMixColumns.v}
# vlog {michaelehab_AES-Verilog/inverseSbox.v}
# vlog {michaelehab_AES-Verilog/inverseShiftRows.v}
# vlog {michaelehab_AES-Verilog/inverseSubBytes.v}
# vlog {michaelehab_AES-Verilog/keyExpansion.v}
# vlog {michaelehab_AES-Verilog/mixColumns.v}
# vlog {michaelehab_AES-Verilog/sbox.v}
# vlog {michaelehab_AES-Verilog/shiftRows.v}
# vlog {michaelehab_AES-Verilog/subBytes.v}
# vlog {michaelehab_AES-Verilog/AES_Decrypt.v}
# vlog {michaelehab_AES-Verilog/AES_Decrypt_tb.v}
# vlog {michaelehab_AES-Verilog/AES_Encrypt_tb.v}

vlog -f srcfiles_dms.f +define+QUESTA

# ------------------------------------

vlog -coveropt 3 +cover +acc {UVM/shared_pkg/shared_pkg.sv}
vlog -coveropt 3 +cover +acc {UVM/objects/sequenceItem/sequenceItem.sv}
vlog -coveropt 3 +cover +acc {UVM/objects/sequences/main_sequence.sv}

vlog -coveropt 3 +cover +acc {UVM/interface/ADC_intf.sv}

vlog -coveropt 3 +cover +acc {UVM/objects/configration/configration.sv}

vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/agent/driver/driver.sv}
vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/agent/monitor/monitor.sv}
vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/agent/sequencer/sequencer.sv}

vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/agent/agent.sv}
vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/scoreboard/scoreboard.sv}
vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/subscriber/subscriber.sv}

vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/env/env.sv}

vlog -coveropt 3 +cover +acc {UVM/testbench_top/test/test.sv}
vlog -coveropt 3 +cover +acc {UVM/testbench_top/top.sv}

# ------------------------------------

vsim +UVM_VERBOSITY=UVM_LOW -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint  \
sim:/top/GMif/*

run -all
# quit -sim