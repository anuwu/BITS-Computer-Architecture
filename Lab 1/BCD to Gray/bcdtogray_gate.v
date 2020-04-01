module bcdtogray_gate (b3,b2,b1,b0,g3,g2,g1,g0) ;
	input b0,b1,b2,b3 ;
	output g0,g1,g2,g3 ;
	
	buf b1(g3 , b3) ;
	xor x2(g2 , b3 , b2) ;
	xor x1(g1 , b2 , b1) ;
	xor x0(g0 , b1 , b0) ;
endmodule

module testbench ;
	reg b3,b2,b1,b0 ;
	wire g3,g2,g1,g0 ;
	bcdtogray btgg (b3,b2,b1,b0,g3,g2,g1,g0) ;
	initial
		begin
			$monitor (,$time , " b3=%b, b2=%b, b1=%b, b0=%b, g3=%b, g2=%b, g1=%b, g0=%b" , b3,b2,b1,b0,g3,g2,g1,g0) ;
			#1 b3 = 1'b0 ; b2=1'b0 ; b1 = 1'b0 ; b0 = 1'b0 ;
			#1 b0 = 1'b1 ;
			#1 b1 = 1'b1 ; b0 = 1'b0 ;
			#1 b0 = 1'b1 ;
			#1 b2 = 1'b1 ; b1 = 1'b0 ; b0 = 1'b0 ;
			#1 b0 = 1'b1 ;
			#1 b1 = 1'b1 ; b0 = 1'b0 ;
			#1 b0 = 1'b1 ;
			#1 b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
			#1 b3 = 1'b1 ; b2=1'b0 ; b1 = 1'b0 ; b0 = 1'b0 ;
			#1 b0 = 1'b1 ;
		end
endmodule
		
		