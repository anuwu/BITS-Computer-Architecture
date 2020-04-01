module tff (q, t, clk, en, clear) ;
	input t, clk, en, clear ;
	output reg q ;
	
	always @(posedge clk)
	begin
		if (clear)
			q <= 1'b0 ;
		else begin
			if (en) begin
				if (t == 1'b0)
					q <= q ;
				else
					q <= ~q ;
			end
		end
	end
endmodule 