`include "mux3to1.v"

//module mux_3to1 (out, sel, in1, in2, in3) ;

module mux3to1_tb ;
	reg in1, in2, in3 ;
	reg [1:0] sel ;
	wire out ;
	
	mux3to1 m(out, sel, in1, in2, in3) ;
	
	initial begin
		$monitor ("out = %b, sel = %2b, in1 = %b, in2 = %b, in3 = %b", out, sel, in1, in2, in3) ;
	
		in1 = 1'b1 ;
		in2 = 1'b0 ;
		in3 = 1'b1 ;
		sel = 2 ;
		
		#5 sel = 1 ;
		#5 sel = 0 ;
		#5 sel = 2 ; $finish ;
	end
	
endmodule
	