simv:
	xrun test/* hdl/* -gui -access +rw
simv_traces:
	xrun test/* hdl/* -access +rw -input restore.tcl
clean:
	rm -rf waves.shm xcelium.d *.diag xrun.*