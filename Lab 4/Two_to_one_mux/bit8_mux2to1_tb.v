`include "bit8_2to1mux.v"

//module bit8_2to1mux (out, sel, in1, in2) ;

module bit8_2to1mux_tb ;
	reg [7:0] in1, in2 ;
	reg sel ;
	wire [7:0] out ;
	bit8_2to1mux bb (out, sel, in1, in2) ;
	
	initial begin
		in1 = 8'b10101010 ;
		in2 = 8'b01010101 ;
		sel = 1'b0 ;
		$monitor ("out = %8b, sel = %b, in1 = %8b, in2 = %8b\n" , out, sel, in1, in2) ;
		
		#10 sel = 1'b1 ;
		#10 sel = 1'b0 ; $finish ;
	end
endmodule