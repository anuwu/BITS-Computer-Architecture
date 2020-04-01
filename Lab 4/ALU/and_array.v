module and_array (out, a, b) ;
	input [31:0] a, b ;
	output [31:0] out ;
	
	assign {out} = a & b ;
endmodule 
	
	