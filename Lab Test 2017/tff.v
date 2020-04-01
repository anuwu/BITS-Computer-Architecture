module tff (q, t, clk, clear) ;
	input t, clk, clear ;
	output reg q ;
	
	always @(posedge clk or posedge clear)
	begin
		if (clear)
			q <= 1'b0 ;
		else begin
			if (t == 0)
				q <= q ;
			else
				q <= ~q ;	
		end
	end
endmodule 