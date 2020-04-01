`include "and_array.v"
`include "or_array.v" 
`include "adder_array.v"
`include "not_array.v"
`include "bit32_mux3to1.v"
`include "bit32_mux2to1.v"

module alu (result, carryout, a, b, op, binvert, carryin) ;
	input[31:0] a, b ;
	input[1:0] op ;
	input binvert, carryin ;
	output[31:0] result ;
	output carryout ;
	
	wire[31:0] notb, and_res, or_res, add_res, m21_res ;
	
	not_array na (notb, b) ;
	bit32_mux2to1 m21 (m21_res, binvert, b, notb) ;
	and_array aa (and_res, a, m21_res) ;
	or_array oa (or_res, a, m21_res) ;
	adder_array addera (add_res, carryout, carryin, a, m21_res) ;
	bit32_mux3to1 m31 (result, op, and_res, or_res, add_res) ;
	
endmodule