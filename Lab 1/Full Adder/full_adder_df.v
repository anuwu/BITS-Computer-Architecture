module full_adder_df (a , b , cin , s , cout) ;
	input a , b , cin ;
	output s , cout ;
	
	wire x1 ;
	assign x1 = (a & ~b) | (~a & b) ;
	assign s = (cin & ~x1) | (~cin & x1) ;
	
	assign cout = (a & b) | (a & cin) | (b & cin) ;
endmodule 

module testbench ;
	reg a , b , c_in ;
	wire s , c_out ;
	full_adder_df fa (a , b , c_in , s , c_out) ;
	
	initial
		begin
			$monitor ( , $time , " %b %b %b | %b %b " , a , b , c_in , s , c_out) ;
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