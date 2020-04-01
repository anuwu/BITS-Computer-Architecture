module mux3to1 (out, sel, in1, in2, in3) ;
	input in1, in2, in3 ;
	input [1:0] sel ;
	output out ;
	reg out ;			//If using behavioural modelling, then declare as reg.
	
	always @(sel or in1 or in2 or in3)
		/*
		if (sel[1] == 0 && sel[0] == 0)
			out = in1 ;
		else if (sel[1] == 0 && sel[0] == 1)
			out = in2 ;
		else if (sel[1] == 1 && sel[0] == 0)
			out = in3 ;
		*/
		
		if (sel[1:0] == 0)
			out = in1 ;
		else if (sel[1:0] == 1)
			out = in2 ;
		else if (sel[1:0] == 2)
			out = in3 ;
		
endmodule