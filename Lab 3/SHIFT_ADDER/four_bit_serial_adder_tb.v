`include "four_bit_serial_adder.v"

module testbench ;
	parameter n = 4 ;
	reg shift, serial_in, carry_rst, clk ;
	wire [n-1:0] A, B ;
	wire carryQ ;
	
	four_bit_serial_adder FBSA (A, B, carryQ, shift, serial_in, carry_rst, clk) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		carry_rst = 1 ;
		serial_in = 0 ;
		shift = 0 ;
		
		$display ("Louda\n") ;
		$monitor ("clk = %b, carry_rst = %b, shift = %b, A = %4b, B = %4b, carry = %b\n", clk, carry_rst, shift, A, B, carryQ) ;
		$dumpfile ("four_bit_serial_adder_tb.vcd") ;
		$dumpvars (0 , testbench) ;
		
		#2 carry_rst = 0 ;
		#1 carry_rst = 1 ;
		#2 shift = 1 ;
		#10 shift = 1 ;
		#10 shift = 1 ;
		#10 shift = 1 ;
		#10 shift = 0 ; $finish ;
	end
endmodule