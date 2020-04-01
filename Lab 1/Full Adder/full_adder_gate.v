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

module testbench ;
	reg a , b , c_in ;
	wire s , c_out ;
	full_adder_gate fa (a , b , c_in , s , c_out) ;

	
	initial
		begin
			$monitor ( , $time , " %b %b %b | %b %b " , a , b , c_in , s , c_out) ;
			$dumpfile ("adder.vcd") ;
			$dumpvars (0, testbench) ;
			#1 c_in = 1'b0 ; a = 1'b0 ; b = 1'b0 ;
			#1 b = 1'b1 ;
			#1 a = 1'b1 ; b = 1'b0 ;
			#1 b = 1'b1 ;
			#1 c_in = 1'b1 ; a = 1'b0 ; b = 1'b0 ;
			#1 b = 1'b1 ;
			#1 a = 1'b1 ; b = 1'b0 ;
			#1 b = 1'b1 ; 
			$finish ;
		end

endmodule
