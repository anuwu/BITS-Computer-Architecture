`include "bit32_mux3to1.v"

module bit32_mux3to1_tb ;
	reg [31:0] in1, in2, in3 ;
	reg [1:0] sel ;
	wire [31:0] out ;
	
	bit32_mux3to1 m (out, sel, in1, in2, in3) ;
	
	initial begin
	
		$monitor ("out = %d, sel = %d, in1 = %d, in2 = %d, in3 = %d", out, sel, in1, in2, in3) ;
	
		in1[31:0] = 76 ;
		in2[31:0] = 90 ;
		in3[31:0] = 555 ;
		sel[1:0] = 0 ;
		
		#5 sel = 1 ;
		#5 sel = 2 ;
		#5 in3 = 9999999 ;
		#5 in2 = 1023 ; sel = 1 ;
		#5 in1 = 23322 ; sel = 0 ;
		$finish ;
	
	end
	
endmodule 