module SAR_Controller #(
	parameter NUM_BITS = 4
) (
	SAR_Controller_if.DUT intf
);

	// sample_sig: 	a pulse is sent at Sample Rate or just after rst_n deassertion

	logic [NUM_BITS:0] counter;
	logic start_operation;
	logic [NUM_BITS:0] rate;


	always @(posedge intf.clk or negedge intf.rst_n) begin
		if(!intf.rst_n) begin
			rate<=NUM_BITS + 1;
		end
		else begin
			//here we determine sample rate
			//ASSUMING CLOCK FREQ = 100 MHZ

			if (intf.sample_sig) begin
				case (intf.sample_rate)
					2'b00: rate <=  NUM_BITS + 1; //20 MHZ 
					2'b01: rate <=  2*(NUM_BITS + 1); // 10 MHZ
					2'b10: rate <=  3*(NUM_BITS + 1); // 6.7 MHZ
					2'b11: rate <=  4*(NUM_BITS + 1); // 5 MHZ
						default : rate <= NUM_BITS + 1;
				endcase
			end	
		end
	end


	
	always @(posedge intf.clk or negedge intf.rst_n) begin
		if(!intf.rst_n) begin
			counter<='b0;
			intf.sample_sig <= 1'b0;
			start_operation <=1'b1;

		end
		else begin
			if(counter == rate - 1'b1) begin
				intf.sample_sig <= 1'b1;
				counter <= 0;
			end
			else begin
				if(counter==0 && start_operation) begin
					intf.sample_sig <= 1'b1;
				end
				else begin
					intf.sample_sig <= 1'b0;
					counter <= counter + 1;
				end
				start_operation <=1'b0;
			end
		end
	end

endmodule : SAR_Controller