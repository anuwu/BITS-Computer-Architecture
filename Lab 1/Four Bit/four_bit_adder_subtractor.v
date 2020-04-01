module full_adder_gate (a , b , c_in , s , c_out) ;
	input a, b, c_in ;
	output s, c_out ;
	
	wire sw1 , c_and1 , c_and2 , c_and3 , c_or1 ;
	
	xor (sw1 , a , b) ;
	xor (s , sw1 , c_in) ;
	
	and (c_and1 , a , b) ;
	and (c_and2 , a , c_in) ;
	and (c_and3 , b , c_in) ;
	or (c_or1 , c_and1 , c_and2) ;
	or (c_out , c_or1 , c_and3) ;
	
endmodule

module four_bit_adder_subtractor_gate (a3 , a2 , a1 , a0 , b3 , b2 , b1 , b0, M, s3, s2, s1, s0 , cout , ovf) ;
	input a3, a2, a1, a0, b3, b2, b1, b0, M ;
	output s3 , s2 , s1 , s0 , cout , ovf ;
	
	wire bin3 , bin2 , bin1, bin0, cout0 , cout1 , cout2 ;
	xor (bin3 , b3 , M) ;
	xor (bin2, b2 , M) ;
	xor (bin1 , b1 , M) ;
	xor (bin0 , b0, M) ;
	
	full_adder_gate fa0 (a0 , bin0 , M , s0 , cout0) ;
	full_adder_gate fa1 (a1 , bin1 , cout0 , s1 , cout1) ;
	full_adder_gate fa2 (a2 , bin2 , cout1 , s2 , cout2) ;
	full_adder_gate fa3 (a3 , bin3 , cout2 , s3 , cout) ;
	
	xor (ovf , cout , cout2) ;
	
endmodule

module testbench ;
	reg a3 , a2 , a1 , a0 , b3 , b2 , b1 , b0 , M ;
	wire s3, s2, s1, s0, cout, ovf ;
	
	four_bit_adder_subtractor_gate fbas (a3, a2, a1, a0, b3, b2, b1, b0, M, s3, s2, s1, s0, cout, ovf) ;
	initial
		begin
			$monitor ("#", $time, " %b | %b %b %b %b | %b %b %b %b | %b %b %b %b | %b %b" , M, a3, a2, a1, a0, b3, b2, b1, b0, s3, s2, s1, s0 , cout, ovf) ;
			#1 M = 1'b0 ; a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
			#1 M = 1'b0 ; a3 = 1'b1 ; a2 = 1'b0 ; a1= 1'b0 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b0 ; b0 = 1'b0 ;
			#1 M = 1'b1 ; a3 = 1'b0 ; a2 = 1'b0 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
			#1 M = 1'b0 ; a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
			#1 M = 1'b1 ; a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b0 ; b0 = 1'b1 ;
			#1 M = 1'b1 ;a3 = 1'b1 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
			#1 M = 1'b0 ;a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b0 ; b0 = 1'b0 ;
			$finish ;
		end
endmodule