module Sign_Extender(out, in);
	input [15:0] in;
	output [31:0] out;
	reg[31:0] out ;
	always @(in)
		out = { {16{in[15]}}, in};	
endmodule