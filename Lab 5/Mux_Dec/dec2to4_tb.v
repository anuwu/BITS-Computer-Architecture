`include "dec2to4.v"

module dec2to4_tb ;
	reg[1:0] in ;
	wire[3:0] out ;
	
	dec2to4 d (out, in) ;
	
	initial begin
		$monitor ("out = %4b, in = %2b\n", out, in) ;
		
		#0 in = 0 ;
		#1 in = 1 ;
		#1 in = 2 ;
		#1 in = 3 ;
		#1 in = 2 ;
		#1 in = 0 ; $finish ;
	
	end
	
endmodule