module SAR (SAR_if.DUT intf);
reg [2:0] counter;
always @(posedge intf.clk or negedge intf.rst_n) begin
	if(~intf.rst_n) begin
		intf.digital_signal <= 4'b1000;
		counter<=3'b000;
		intf.valid<=0;
	end else begin
		case (counter)
			3'b000:begin
				intf.valid<=0;
				intf.digital_signal<=4'b1000;
				if(intf.sample_sig)
					counter<=counter+1;
			end
			3'b001:begin
				intf.valid<=0;
				intf.digital_signal[2]<=1;
				counter<=counter+1;
				if(intf.comparator_out)
					intf.digital_signal[3]<=1;
				else 
					intf.digital_signal[3]<=0;
			end
			3'b010:begin
				intf.valid<=0;
				intf.digital_signal[1]<=1;
				counter<=counter+1;
				if(intf.comparator_out)
					intf.digital_signal[2]<=1;
				else 
					intf.digital_signal[2]<=0;
			end
			3'b011:begin
				intf.valid<=0;
				intf.digital_signal[0]<=1;
				counter<=counter+1;
				if(intf.comparator_out)
					intf.digital_signal[1]<=1;
				else 
					intf.digital_signal[1]<=0;
			end
			3'b100:begin
				intf.valid<=1;
				counter<=0;
				if(!intf.comparator_out)
					intf.digital_signal[0]<=0;
			end
		endcase
	end
end
endmodule : SAR