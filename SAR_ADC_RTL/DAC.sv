module DAC #(
	parameter real 	V_SCALE 	= 16.0,
	parameter 			NUM_BITS	= 4
) (
	input 			[NUM_BITS-1:0]  D_in,
	output real									A_out
);

	always @(*)
		A_out = (D_in*V_SCALE)/(2**NUM_BITS);
	
endmodule : DAC