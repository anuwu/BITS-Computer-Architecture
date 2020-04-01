`include "bit32_reg.v"

module bit32_reg_tb ;
	reg rst, clk ;
	reg[31:0] inp ;
	wire[31:0] dat ;
	
	bit32_reg register (dat, clk, rst, inp) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		rst = 1 ;
		
		$dumpfile ("bit32_reg_tb.vcd") ;
		$dumpvars (0,bit32_reg_tb) ;
		
		#1 rst = 0 ;
		#1 rst = 1 ;
		#3 inp = 1 ;
		#7 inp = 2;
		#10 inp = 1 ;
		$finish ;
		
	end
	
endmodule