module and3 (out , a , b , c) ;
	input a, b, c ;
	output out ;
	
	wire w1 ;
	and (w1 , a , b) ;
	and (out, w1, c) ;
endmodule

module and4 (out , a, b, c, d) ;
	input a, b, c, d ;
	output out ;
	
	wire w1, w2 ;
	and (w1, a, b) ;
	and (w2, w1, c) ;
	and (out, w2, d) ;
endmodule

module or4 (out, a, b, c, d) ;
	input a, b, c, d ;
	output out ;
	
	wire w1, w2 ;
	or (w1, a, b) ;
	or (w2, w1, c) ;
	or (out, w2, d) ;
endmodule


module four_bit_mag_comp_gate (a3, a2, a1, a0, b3, b2, b1, b0, lesser, greater, eq) ;
	input a3, a2, a1, a0, b3, b2, b1, b0 ;
	output lesser, greater, eq ;
	
	wire na3, nb3, na2, nb2, na1, nb1, na0, nb0 ;
	wire a3nb3, b3na3, a2nb2, b2na2, a1nb1, b1na1, a0nb0, b0na0 ;
	wire x3, x2, x1, x0 ;
	wire x3b2, x3x2b1, x3x2x1b0 ;
	wire x3a2, x3x2a1, x3x2x1a0 ;
	
	
	not (na3, a3) ;
	not (na2, a2) ;
	not (na1, a1) ;
	not (na0, a0) ;
	
	not (nb3, b3) ;
	not (nb2, b2) ;
	not (nb1, b1) ;
	not (nb0, b0) ;
	
	and (a3nb3, a3 , nb3) ;
	and (b3na3 , b3, na3) ;
	and (a2nb2, a2 , nb2) ;
	and (b2na2, b2, na2) ;
	and (a1nb1, a1 , nb1) ;
	and (b1na1, b1, na1) ;
	and (a0nb0, a0 , nb0) ;
	and (b0na0, b0, na0) ;
	
	nor (x3 , a3nb3 , b3na3) ;
	nor (x2 , a2nb2 , b2na2) ;
	nor (x1 , a1nb1 , b1na1) ;
	nor (x0 , a0nb0 , b0na0) ;
	
	and (x3b2 , x3, b2na2) ;
	and3 bee_1(x3x2b1 , x3 , x2 , b1na1) ;
	and4 bee_0(x3x2x1b0 , x3, x2, x1, b0na0) ;
	
	and (x3a2 , x3 , a2nb2) ;
	and3 aay_1(x3x2a1 , x3, x2, a1nb1) ;
	and4 aay_0(x3x2x1a0, x3, x2, x1, a0nb0) ;
	
	and4 eq_and(eq, x3, x2, x1, x0) ;
	or4 less_or(lesser, b3na3 , x3b2, x3x2b1, x3x2x1b0) ;
	or4 great_or(greater, a3nb3 , x3a2, x3x2a1, x3x2x1a0) ;
endmodule

module testbench ;
	reg a3, a2, a1, a0, b3, b2, b1, b0 ;
	wire eq, lesser, greater ;
	
	four_bit_mag_comp_gate fbmc (a3, a2, a1, a0, b3, b2, b1, b0, lesser, greater, eq) ;
	
	initial
		begin
		$monitor ("#" , $time, " %b %b %b %b | %b %b %b %b | %b %b %b " , a3, a2, a1, a0, b3, b2, b1, b0, lesser, greater, eq) ;
		#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
		#1 a3 = 1'b1 ; a2 = 1'b0 ; a1= 1'b0 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b0 ; b0 = 1'b0 ;
		#1 a3 = 1'b0 ; a2 = 1'b0 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
		#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
		#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b0 ; b0 = 1'b1 ;
		#1 a3 = 1'b1 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
		$finish ;
		end
endmodule 