`include "adder_array.v" 

// module adder_array (sum, cout, cin, a, b) ;

module adder_array_tb ;
	reg cin ;
	reg[31:0] a, b;
	wire[31:0] sum ;
	wire cout ;
	
	adder_array addy (sum, cout, cin, a, b) ;
	
	initial begin
		$monitor ("sum=%d, cout=%b, cin=%b, a=%d, b=%d\n", sum, cout, cin, a, b) ;
		a = 9933 ;
		b = 3378 ;
		cin = 0 ;
		
		#5 a = 127 ; b = 0 ; cin = 1 ;
		#5 a = 32'b11111111_11111111_11111111_11111111 ; b = 1 ; cin = 0 ;
		$finish ;
	
	end
	
endmodule