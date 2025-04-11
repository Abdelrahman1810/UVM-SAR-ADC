module comparator (
	input 			 	clk,
	input 	real 	V1, V2, 	// V1: V_target, V2: A_FB
	output 	reg		cmp_out
);

	always @(negedge clk) begin
		if(V1 > V2)
			cmp_out <= 1;
		else
			cmp_out <= 0;
	end

endmodule : comparator