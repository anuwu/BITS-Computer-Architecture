module dff (q, d, clk, reset, set) ;
	input d, clk, reset, set ;
	output reg q ;
	
	always @(posedge clk or posedge reset or posedge set)
	begin
			if (reset)
				q <= 1'b0 ;
			else if (set)
				q <= 1'b1 ;
			else
				q <= d ;
	end
endmodule

module cl (t2, t1, t0, s, z, x, clk, rst, set) ;
	input s, z, x, clk, rst, set ;
	output t2, t1, t0 ;
	
	wire sbar, xbar, zbar, w11, w12, w21, w22, w23, w31, w32 ;
	wire d0, d1, d2 ;
	
	not (xbar, x) ;
	not (zbar, z) ;
	not (sbar, s) ;
	
	and (w11, t0, sbar) ;
	and (w12, t2, z) ;
	and (w21, t0, s) ;
	and (w22, t2, xbar, zbar) ;
	and (w23, t1, xbar) ;
	and (w31, t1, x) ;
	and (w32, t2, zbar, x) ;
	
	or (d0, w11, w12) ;
	or (d1, w21, w22, w23) ;
	or (d2, w31, w32) ;
	
	dff f0 (t0, d0, clk, 1'b0, set) ;
	dff f1 (t1, d1, clk, rst, 1'b0) ;
	dff f2 (t2, d2, clk, rst, 1'b0) ;
	
endmodule 