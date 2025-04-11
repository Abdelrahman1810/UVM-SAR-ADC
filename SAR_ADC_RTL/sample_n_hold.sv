module sample_n_hold (
	input 	 		 clk,		// Sample Signal
	input 	real Vin,
	output 	real V_target
);

	always @(posedge clk) begin
		V_target <= Vin;
	end

endmodule : sample_n_hold