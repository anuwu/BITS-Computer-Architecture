module full_adder (s , cout, a , b , cin) ;
	input a , b , cin ;
	output s , cout ;
	
	wire x1 ;
	assign x1 = (a & ~b) | (~a & b) ;
	assign s = (cin & ~x1) | (~cin & x1) ;
	
	assign cout = (a & b) | (a & cin) | (b & cin) ;
endmodule 
