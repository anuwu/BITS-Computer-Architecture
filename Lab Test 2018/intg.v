`include "counter.v"
`include "cl.v"
`timescale 1ms/1ns

//module dff (q, d, clk) ;
//module counter (a3, a2, a1, a0, clk, synclr, en) ;
//module cl (t2, t1, t0, s, z, x, clk, rst, set) ;

module intg (a3, a2, a1, a0, s, x, clk, reset, set) ;
	input s, clk, x, reset, set ;
	output a3, a2, a1, a0 ;
	
	wire synclr, en, en1, en2, z, zbar, x ;
	wire t2, t1, t0 ;
	
	cl controller (t2, t1, t0, s, z, x, clk, reset, set) ;
	
	and (synclr, t0, s) ;
	
	not (zbar, z) ;
	and (en1, t1, x) ;
	and (en2, t2, zbar, x) ;
	or (en, en1, en2) ;
	
	counter count (a3, a2, a1, a0, clk, synclr, en) ;
	and (z, a3, a2, a1, a0) ;
	
	wire gd, g;
	and (gd, z, t2) ;
	
	dff gff (g, gd, clk, synclr, 1'b0) ;
endmodule 

module tb ;
	reg s, x, clk, reset, set ;
	wire a3, a2, a1, a0 ;
	integer i ;
	
	intg integrate (a3, a2, a1, a0, s, x, clk, reset, set) ;
	
	always #0.5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		reset = 0 ;		
		set = 0 ;		
		x = 1 ;
		s = 1 ;
		
		//$monitor ($time, " a3=%b, a2=%b, a1=%b, a0=%b, z=%b, g=%b\n", a3, a2, a1, a0, integrate.z, integrate.g) ;
		$dumpfile ("plot.vcd") ;
		$dumpvars (0, tb) ;
		
		#0.1 reset = 1 ; set = 1 ; //Resets controller flip-flops t1 and t2 and Sets controller flip-flop t0.
		#0.1 reset = 0 ; set = 0 ;
		#0.3 ;
		for (i = 0 ; i < 17 ; i++) begin
			$display ($time, " a3=%b, a2=%b, a1=%b, a0=%b, z=%b, g=%b\n", a3, a2, a1, a0, integrate.z, integrate.g) ;
			#1 ;
		end
		
		$finish ;
	end
		
endmodule 
		
		
	
	
	
	