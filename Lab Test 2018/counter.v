`include "tff.v"

//module tff (q, t, clk, en, clear) ;

module counter (a3, a2, a1, a0, clk, synclr, en) ;
	input clk, synclr, en ;
	output a3, a2, a1, a0 ;
	
	wire w1, w2 ;
	
	tff t0 (a0, 1'b1, clk, en, synclr) ;
	tff t1 (a1, a0, clk, en, synclr) ;
	
	and (w1, a0, a1) ;
	tff t2 (a2, w1, clk, en, synclr) ;
	
	and (w2, w1, a2) ;
	tff t3(a3, w2, clk, en, synclr) ;
endmodule
	