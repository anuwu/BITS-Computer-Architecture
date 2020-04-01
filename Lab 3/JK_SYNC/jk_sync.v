module jk_sync (j, k, clearb, clk, q) ;
	input j, k, clearb, clk ;
	output q ;
	reg q ;
	
	always @(posedge clk)
	begin
		if (!clearb) 
			q <= 1'b0 ;
		else 
			if (j == 1'b0 && k == 1'b0) 
				q <= q ;
			else if (j == 1'b0 && k == 1'b1) 
				q <= 1'b0 ;
			else if (j == 1'b1 && k == 1'b0) 
				q <= 1'b1 ;
			else if (j == 1'b1 && k == 1'b1) 
				q <= ~q ;
	end
endmodule