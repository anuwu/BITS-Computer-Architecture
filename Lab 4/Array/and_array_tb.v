`include "and_array.v"

module and_array_tb ;
	reg[31:0] a, b ;
	wire[31:0] out ;
	
	and_array A(out, a, b) ;
	
	initial begin
		$monitor ("o = %32b \na = %32b \nb = %32b \n-------\n", out, a, b) ;
		
		a = 94836458 ;
		b = 4534534 ;
		
		#5 a = 26483645 ; b = 987654 ;
		#5 a = 3456 ; b = 76348754 ; $finish ;
	
	end
	
endmodule