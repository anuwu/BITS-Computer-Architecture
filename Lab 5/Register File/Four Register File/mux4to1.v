module mux4to1 (out, sel, in0, in1, in2, in3) ;
	input[31:0] in1, in2, in3, in0 ;
	input[1:0] sel ;
	output[31:0] out ;
	reg[31:0] out ;
	
	always @(in0 or in1 or in2 or in3 or sel)
	begin
		case (sel)
			0 : out = in0 ;
			1 :	out = in1 ;
			2 : out = in2 ;
			3 : out = in3 ;
		endcase
	end
endmodule