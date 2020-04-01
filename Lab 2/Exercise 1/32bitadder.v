module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

//Do not use the input as an array if it can't be interpreted as one. Don't think of testbench simplicity.
module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7,
	 c = d3 | d5 | d6 | d7;
endmodule


module eight_bitadder (out , cout , a , b , cin) ;
	// Be very careful about the indexing of arrays.
	output [7:0] out ;
	output cout ;
	input [7:0] a, b ;
	input cin ;
	
	wire c0, c1, c2, c3, c4, c5, c6, c7 ;
	
	FADDER f0 (out[0] , c0 , cin , a[0] , b[0]) ;
	FADDER f1 (out[1] , c1 , c0 , a[1] , b[1]) ;
	FADDER f2 (out[2] , c2 , c1 , a[2] , b[2]) ;
	FADDER f3 (out[3] , c3 , c2 , a[3] , b[3]) ;
	FADDER f4 (out[4] , c4 , c3 , a[4] , b[4]) ;
	FADDER f5 (out[5] , c5 , c4 , a[5] , b[5]) ;
	FADDER f6 (out[6] , c6 , c5 , a[6] , b[6]) ;
	FADDER f7 (out[7] , c7 , c6 , a[7] , b[7]) ;
	
	buf (cout , c7) ;
endmodule


module thirtytwo_bitadder (out, cout, a, b, cin) ;
	output [31:0] out ;
	output cout ;
	
	input [31:0] a, b ;
	input cin ;
	
	wire cout0, cout1, cout2 ;
	eight_bitadder eba0 (out[7:0], cout0, a[7:0], b[7:0], cin) ;
	eight_bitadder eba1 (out[15:8] , cout1, a[15:8], b[15:8], cout0) ;
	eight_bitadder eba2 (out[23:16] , cout2, a[23:16], b[23:16], cout1) ;
	eight_bitadder eba3 (out[31:24] , cout, a[31:24], b[31:24], cout2) ;
	
endmodule

module testbench ;
	reg[31:0] a, b ;
	reg cin ;
	
	wire [31:0] out ;
	wire cout ;
	
	thirtytwo_bitadder ttba (out , cout , a , b ,cin) ;
	
	initial
		begin
			$monitor (, $time, " a = %b | b = %b | sum = %b | cout = %b " , a , b , out , cout) ;
			#0 a = 32'b01111111_11111111_11111111_11111111 ; b = 32'b00000000_00000000_00000000_00000001 ; cin = 1'b0 ;
			$finish ;
			
		end
		
endmodule 