`include "not_array.v"

module not_array_tb ;
	reg[31:0] in ;
	wire[31:0] out ;
	wire[31:0] test ;
	
	assign test = in | out ;
	
	not_array n (out, in) ;
	
	initial begin
		$monitor ("out = %32b, in = %32b, test = %32b\n", out, in, test) ;
		
		in = 32'b00000000_11111111_00000000_11111111 ;
		#5 in = 2533534 ;
		#5 in = 34353495 ; $finish ;
	
	
	end
	
endmodule 