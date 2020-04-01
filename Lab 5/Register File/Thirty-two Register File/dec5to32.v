module dec5to32 (out, in) ;
	input[4:0] in ;
	output[31:0] out ;
	reg[31:0] out ;
	
	always @(in)
	begin
		/*
		case(in)
			0 :	out = 4'b0001 ;
			1 : out = 4'b0010 ; 
			2 : out = 4'b0100 ;
			3 : out = 4'b1000 ;
		endcase*/
		
		//i = in ;
		out = 2**in ;
	end
	
endmodule
	