module full_adder_beh (sum, cout, cin, a, b) ;
	input cin, a, b ;
	output sum, cout ;
	reg sum, cout ;
	
	always @(cin or a or b)
		if (cin == 0)
			begin
			cout = 0 ;
			
			if (a == 1 || b == 1)
				begin
				sum = 1 ;
				end
			else
				begin
				sum = 0 ;
				end
				
			if (a == 1 && b == 1)
				begin
				sum = 0 ;
				cout = 1 ;
				end
				
			end
		else
			begin
			cout = 1 ;
			
			if (a == 0 || b == 0)
				begin
				sum = 0 ;
				end
			else
				begin
				sum = 1 ;
				end
			
			if (a == 0 && b == 0)
				begin
				sum = 1 ;
				cout = 0 ;
				end
				
			end
endmodule

module testbench ;
	reg cin, a, b ;
	wire sum, cout ;
	
	full_adder_beh fa (sum, cout, cin, a, b) ;
	
	initial
		begin
		$monitor (, $time, "cin = %b | a = %b | b = %b | sum = %b | cout = %b" , cin, a, b, sum, cout) ;
		#0 cin = 1'b0 ; a = 1'b0 ; b = 1'b0 ;
		#1 cin = 1'b0 ; a = 1'b0 ; b = 1'b1 ;
		#1 cin = 1'b0 ; a = 1'b1 ; b = 1'b0 ;
		#1 cin = 1'b0 ; a = 1'b1 ; b = 1'b1 ;
		#1 cin = 1'b1 ; a = 1'b0 ; b = 1'b0 ;
		#1 cin = 1'b1 ; a = 1'b0 ; b = 1'b1 ;
		#1 cin = 1'b1 ; a = 1'b1 ; b = 1'b0 ;
		#1 cin = 1'b1 ; a = 1'b1 ; b = 1'b1 ;
		$finish ;
		end
endmodule


