`include "mux3to1.v"

module bit8_mux3to1 (out, sel, in1, in2, in3) ;
	input [7:0] in1, in2, in3 ;
	input [1:0] sel ;
	output [7:0] out ;
	
	mux3to1 m0 (out[0], sel, in1[0], in2[0], in3[0]) ;
	mux3to1 m1 (out[1], sel, in1[1], in2[1], in3[1]) ;
	mux3to1 m2 (out[2], sel, in1[2], in2[2], in3[2]) ;
	mux3to1 m3 (out[3], sel, in1[3], in2[3], in3[3]) ;
	mux3to1 m4 (out[4], sel, in1[4], in2[4], in3[4]) ;
	mux3to1 m5 (out[5], sel, in1[5], in2[5], in3[5]) ;
	mux3to1 m6 (out[6], sel, in1[6], in2[6], in3[6]) ;
	mux3to1 m7 (out[7], sel, in1[7], in2[7], in3[7]) ;
	
endmodule 