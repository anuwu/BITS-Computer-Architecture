`include "bit32_2to1mux.v"

//module bit32_2to1mux (out, sel, in1, in2) ;

module bit32_2to1mux_tb ;
	reg [31:0] in1, in2 ;
	reg sel ;
	wire [31:0] out ;
	
	bit32_2to1mux m (out, sel, in1, in2) ;
	
	initial begin
		$monitor ("out = %32b, sel = %b, in1 = %32b, in2 = %32b", out, sel, in1, in2) ;
		sel = 1'b0 ;
		in1 = 32'b11111111000000001111111100000000 ;
		in2 = 32'b00000000111111110000000011111111 ;
		
		#5 sel = 1'b1 ;
		#5 sel = 1'b0 ; $finish ;
	
	
	end
	
endmodule 