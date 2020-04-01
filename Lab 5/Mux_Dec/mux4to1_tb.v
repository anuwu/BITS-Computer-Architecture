`include "mux4to1.v"

//module mux4to1 (out, sel, in0, in1, in2, in3) ;

module mux4to1_tb ;
	reg[31:0] in1, in2, in3, in0 ;
	reg[1:0] sel ;
	wire[31:0] out ;
	
	mux4to1 m (out, sel, in0, in1, in2, in3) ;
	
	initial begin
		$monitor ("out=%d, sel=%2b, in0=%d, in1=%d, in2=%d, in3=%d\n", out, sel, in0, in1, in2, in3) ;
		
		in0 = 127 ;
		in1 = 255 ;
		in2 = 1023 ;
		in3 = 2047 ;
		sel = 0 ;
		
		#1 sel = 1 ;
		#1 sel = 2 ;
		#1 sel = 3 ;
		#1 sel = 1 ;
		#1 sel = 0 ;
		#1 sel = 2 ; $finish ;
	end
endmodule