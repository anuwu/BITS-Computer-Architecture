`include "bit8_mux3to1.v"

//module bit8_mux3to1 (out, sel, in1, in2, in3) ;

module bit32_mux3to1 (out, sel, in1, in2, in3) ;
	input [31:0] in1, in2, in3 ;
	input [1:0] sel ;
	output [31:0] out ;
	
	bit8_mux3to1 m0 (out[7:0], sel, in1[7:0], in2[7:0], in3[7:0]) ;
	bit8_mux3to1 m1 (out[15:8], sel, in1[15:8], in2[15:8], in3[15:8]) ;
	bit8_mux3to1 m2 (out[23:16], sel, in1[23:16], in2[23:16], in3[23:16]) ;
	bit8_mux3to1 m3 (out[31:24], sel, in1[31:24], in2[31:24], in3[31:24]) ;
	
endmodule 