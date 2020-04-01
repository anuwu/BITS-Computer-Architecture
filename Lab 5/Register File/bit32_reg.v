module bit32_reg (dat, clk, rst, inp) ;
	input rst, clk ;
	input[31:0] inp ;
	output[31:0] dat ;
	reg[31:0] dat ;
	
	always @(posedge clk or negedge rst)
	begin
		if (!rst)
			dat <= 0 ;
		else
			dat <= inp ;
	end
			
endmodule
	