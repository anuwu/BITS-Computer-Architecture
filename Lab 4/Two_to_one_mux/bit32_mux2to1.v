`include "bit8_2to1mux.v"

//module bit8_2to1mux (out, sel, in1, in2) ;

module bit32_2to1mux (out, sel, in1, in2) ;
	input [31:0] in1, in2 ;
	input sel ;
	output [31:0] out ;
	wire [31:0] out ;
	
	bit8_2to1mux m0 (out[7:0], sel, in1[7:0], in2[7:0]) ;
	bit8_2to1mux m1 (out[15:8], sel, in1[15:8], in2[15:8]) ;
	bit8_2to1mux m2 (out[23:16], sel, in1[23:16], in2[23:16]) ;
	bit8_2to1mux m3 (out[31:24], sel, in1[31:24], in2[31:24]) ;
endmodule