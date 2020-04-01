`include "full_adder.v"
`include "reg1.v"
`include "reg2.v"
`include "..\DFF_ASYNC\dff_async.v"

/*
carry_rst is active low to clear the D flip-flop containing the carry bit.
*/

module four_bit_serial_adder (A, B, carryQ, shift, serial_in, carry_rst, clk) ;
	parameter n = 4 ;
	input shift, serial_in, carry_rst, clk ;
	output carryQ ;
	output [n-1:0] A, B ;
	
	wire [n-1:0] A, B ;
	wire sum, carry, clk_shift ;
	
	and (clk_shift, clk, shift) ;
	
	reg1 srA (shift, sum, clk, A) ;
	reg2 srB (shift, serial_in, clk, B) ;
	dff_async dff (carry, carry_rst, clk_shift, carryQ)  ;
	full_adder FA (sum, carry, A[0] , B[0] , carryQ) ;	
endmodule 
	
	
	
	
	
	
	