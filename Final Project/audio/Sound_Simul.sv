// Uncomment SOUND_SIMUL_0 to simulate using 9 million cycles per sound effect. Good to check the timing in sound_datapath.sv
// Uncomment SOUND_SIMUL_1 to simulate using 10 cycles per sound effect. Good to check the logic in sound.sv
// Uncomment SOUND_SIMUL_2 to see all phases of sound in sound.sv
// Comment all before compiling and uploading to the DE1_SoC

`ifndef SOUND_SIMUL
`define SOUND_SIMUL			1

// comment or uncomment these
//`define SOUND_SIMUL_0		1
//`define SOUND_SIMUL_1		1
//`define SOUND_SIMUL_2		1
`endif

	