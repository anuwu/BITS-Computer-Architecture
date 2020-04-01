``include"..\JK_ASYNC\jk_async.v"

module four_bit_counter (q3, q2, q1, q0, r3, r2, r1, r0, clk) ;
	input clk, r3, r2, r1, r0 ;
	output q3, q2, q1, q0 ;
	wire jk2, jk3 ;

	
	jk_async j0 (1'b1, 1'b1, r0, clk, q0) ;
	jk_async j1 (q0, q0, r1, clk, q1) ;
	and (jk2, q0, q1) ;
	
	jk_async j2 (jk2, jk2, r2, clk, q2) ;
	
	and (jk3, q2, jk2) ;
	jk_async j3 (jk3, jk3, r3, clk, q3) ;	
endmodule

// jk_async (j, k, clearb, clk, q) ;