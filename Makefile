simv:
	xrun test_gaussian_fir.sv gaussian_fir.sv base_fir.sv -gui -access +rw
simv_traces:
	xrun test_gaussian_fir.sv gaussian_fir.sv base_fir.sv -access +rw -input restore.tcl
clean:
	rm -rf waves.shm xcelium.d *.diag xrun.*