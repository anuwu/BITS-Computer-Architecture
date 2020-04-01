module dff_async (d, clearb, clock, q) ;
	input d, clearb, clock ;
	output q ;
	reg q ;
	
	always @(posedge clock or negedge clearb)
	begin
		if (!clearb) 
			q <= 1'b0 ;
		else
			q <= d ;
	end
endmodule 

