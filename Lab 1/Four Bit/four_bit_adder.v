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

module four_bit_adder_gate (a3 , a2 , a1 , a0 , b3 , b2 , b1 , b0, s3, s2, s1, s0 , cout , ovf) ;
	input a3, a2, a1, a0, b3, b2, b1, b0 ;
	output s3 , s2 , s1 , s0 , cout , ovf ;
	
	wire cout0 , cout1 , cout2 ;
	full_adder_gate fa0 (a0 , b0 , 1'b0 , s0 , cout0) ;
	full_adder_gate fa1 (a1 , b1 , cout0 , s1 , cout1) ;
	full_adder_gate fa2 (a2 , b2 , cout1 , s2 , cout2) ;
	full_adder_gate fa3 (a3 , b3 , cout2 , s3 , cout) ;
	
	buf (ovf , cout) ;
	
endmodule

module testbench ;
	reg a3 , a2 , a1 , a0 , b3 , b2 , b1 , b0 ;
	wire s3, s2, s1, s0, cout, ovf ;
	
	four_bit_adder_gate fba (a3, a2, a1, a0, b3, b2, b1, b0, s3, s2, s1, s0, cout, ovf) ;
	initial
		begin
			$monitor ("#", $time, " %b %b %b %b | %b %b %b %b | %b %b %b %b | %b %b" , a3, a2, a1, a0, b3, b2, b1, b0, s3, s2, s1, s0 , cout, ovf) ;
			#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
			#1 a3 = 1'b1 ; a2 = 1'b0 ; a1= 1'b0 ; a0 = 1'b0 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b0 ; b0 = 1'b0 ;
			#1 a3 = 1'b0 ; a2 = 1'b0 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b1 ; b0 = 1'b0 ;
			#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
			#1 a3 = 1'b0 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b0 ; b2 = 1'b0 ; b1 = 1'b0 ; b0 = 1'b1 ;
			#1 a3 = 1'b1 ; a2 = 1'b1 ; a1= 1'b1 ; a0 = 1'b1 ; b3 = 1'b1 ; b2 = 1'b1 ; b1 = 1'b1 ; b0 = 1'b1 ;
			$finish ;
		end
endmodule