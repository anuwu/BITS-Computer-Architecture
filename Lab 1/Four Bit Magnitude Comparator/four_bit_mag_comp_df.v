module four_bit_mag_comp_df (eq, gr, lt, a, b) ;
	input [3:0] a, b ;
	output eq, gr, lt ;
	
	assign eq = (a == b) ? 1 : 0 ,
		   gr = (a > b) ? 1 : 0 ,
		   lt = (a < b) ? 1 : 0 ;

endmodule 

module testbench ;
	reg [3:0] a, b ;
	wire eq, gr, lt ;
	
	four_bit_mag_comp_df fbmc (eq, gr, lt, a, b) ;
	
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