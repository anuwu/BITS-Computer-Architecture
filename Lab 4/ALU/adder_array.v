module adder_array (sum, cout, cin, a, b) ;
	input cin ;
	input[31:0] a, b;
	output[31:0] sum ;
	output cout ;
	
	assign {cout, sum} = a + b + cin ;
endmodule 