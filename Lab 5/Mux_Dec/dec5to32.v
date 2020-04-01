module dec5to32 (out, in) ;
	input[4:0] in ;
	output[31:0] out ;
	reg[31:0] out ;
	
	always @(in)
	begin
		out = 2**in ;
	end
	
endmodule
	