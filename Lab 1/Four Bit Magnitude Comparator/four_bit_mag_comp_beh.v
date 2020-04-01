module four_bit_mag_comp_beh (eq, gr, lt, a, b) ;
	input [3:0] a, b ;
	output eq, gr, lt ;
	reg eq, gr, lt ;
	
	always @(a or b)
		begin
		eq = 1'b0 ;
		gr = 1'b0 ;
		lt = 1'b0 ;
		
		
		if (a == b)
			eq = 1'b1 ;
		else if (a > b)
			gr = 1'b1 ;
		else
			lt = 1'b1 ;
		end

endmodule 

module testbench ;
	reg [3:0] a, b ;
	wire eq, gr, lt ;
	
	four_bit_mag_comp_beh fbmc (eq, gr, lt, a, b) ;
	
	initial
		begin
		$monitor ("#" , $time, " a = %b | b = %b | eq = %b | gr = %b | lt = %b " , a, b, eq, gr, lt) ;
		#0 a = 4'b1000 ; b = 4'b1000 ;
		#1 a = 4'b1001 ; b = 4'b0001 ;
		#1 a = 4'b0011 ; b = 4'b1110 ;
		#1 a = 4'b0000 ; b = 4'b0000 ;
		$finish ;
		end
endmodule 