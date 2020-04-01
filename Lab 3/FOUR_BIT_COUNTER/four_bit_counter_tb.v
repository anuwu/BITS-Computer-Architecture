`include "four_bit_counter.v"

module testbench ;
	reg r3, r2, r1, r0, clk ;
	wire q3, q2, q1, q0 ;
	
	four_bit_counter fbc (q3, q2, q1, q0, r3, r2, r1, r0, clk) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		r3 = 0 ; r2 = 0 ; r1 = 0 ; r0 = 0 ;
		
		$monitor ("q3 = %b, q2 = %b, q1 = %b, q0 = %b\n", q3, q2, q1, q0) ;
		$dumpfile ("four_bit_counter.vcd") ;
		$dumpvars (0, testbench) ;
		
		#5 r3 = 1 ; r2 = 1 ; r1 = 1 ; r0 = 1 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 ;
		#10 $finish ;

	end
endmodule