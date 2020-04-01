`include "tff.v"

//module tff (q, t, clk, en, clear) ;

module counter4 (a, clk, clear) ;
	input clk, clear ;
	output[3:0] a ;
	
	wire w1, w2 ;
	
	tff t0 (a[0], 1'b1, clk, clear) ;
	tff t1 (a[1], a[0], clk, clear) ;
	
	and (w1, a[0], a[1]) ;
	tff t2 (a[2], w1, clk, clear) ;
	
	and (w2, w1, a[2]) ;
	tff t3(a[3], w2, clk, clear) ;
endmodule
	