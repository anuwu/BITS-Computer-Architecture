module mux_small (out, sel, in0, in1) ;
	input in0, in1, sel ;
	output out ;
	
	assign out = (sel) ? in1 : in0 ;
endmodule

module mux_big (out, sel, in) ;
	input[7:0] in ;
	input[2:0] sel ;
	output out ;
	
	wire[3:0] w1 ;
	mux_small m10 (w1[0], sel[0], in[0], in[1]) ;
	mux_small m11 (w1[1], sel[0], in[2], in[3]) ;
	mux_small m12 (w1[2], sel[0], in[4], in[5]) ;
	mux_small m13 (w1[3], sel[0], in[6], in[7]) ;
	
	wire[1:0] w2 ;
	mux_small m20 (w2[0], sel[1], w1[0], w1[1]) ;
	mux_small m21 (w2[1], sel[1], w1[2], w1[3]) ;
	
	mux_small m3 (out, sel[2], w2[0], w2[1]) ;
endmodule