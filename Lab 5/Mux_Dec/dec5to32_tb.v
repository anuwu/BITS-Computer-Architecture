`include "dec5to32.v"

module dec5to32_tb ;
	reg[4:0] in ;
	wire[31:0] out ;
	integer i ;
	
	dec5to32 d (out, in) ;
	
	initial begin
		$monitor ("out = %32b, in = %5b\n", out, in) ;
		
		for (i = 0 ; i < 32 ; i++)
		begin
			#1 in = i ;
		end
		
		#1 in = 4 ;
		$finish ;
	end
	
endmodule