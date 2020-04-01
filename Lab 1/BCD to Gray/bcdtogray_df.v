module bcdtogray_df (b3,b2,b1,b0,g3,g2,g1,g0) ;
	input b0,b1,b2,b3 ;
	output g0,g1,g2,g3 ;
	
	assign g3 = b3 ;
	assign g2 = (b3 & ~b2) | (~b3 & b2) ;
	assign g1 = (b2 & ~b1) | (~b2 & b1) ;
	assign g0 = (b1 & ~b0) | (~b1 & b0) ;
endmodule

module testbench ;
	reg b3,b2,b1,b0 ;
	wire g3,g2,g1,g0 ;
	bcdtogray_df btgdf (b3,b2,b1,b0,g3,g2,g1,g0) ;
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
		
		