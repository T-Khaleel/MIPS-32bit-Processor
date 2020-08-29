onerror {exit -code 1}
vlib work
vlog -work work execute.vo
vlog -work work Waveform8.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.my_package_vlg_vec_tst -voptargs="+acc"
vcd file -direction execute.msim.vcd
vcd add -internal my_package_vlg_vec_tst/*
vcd add -internal my_package_vlg_vec_tst/i1/*
run -all
quit -f
