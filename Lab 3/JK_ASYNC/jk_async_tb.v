`include "jk_async.v"

module testbench ;
	reg j, k, rst, clk ;
	wire q ;
	
	jk_async jk(j, k, rst, clk, q) ;
	
	always #5 clk = ~clk;
	 
	initial begin
		j = 1 ;
		k = 1 ;
		rst = 1 ;
		clk = 0 ;
		$monitor ("rst = %b, clk = %b, j = %b, k = %b, q = %b\n" , rst, clk, j, k, q) ;
		$dumpfile ("jk_async.vcd") ;
		$dumpvars (0, testbench) ;
		
		#5 j = 1'b0 ; k = 1'b1 ;
		#10 j = 1'b0 ; k = 1'b0 ;
		#10 j = 1'b0 ; k = 1'b1 ;
		#10 j = 1'b1 ; k = 1'b0 ;
		#10 j = 1'b1 ; k = 1'b1 ;
		#3 //rst = 0 ;
		#5 //rst = 1 ;
		#3 //rst = 0 ;
		#5 //rst = 1 ;
		#3 j = 1'b1 ; k = 1'b0 ;
		#5 //rst = 1 ;
		#3 j = 1'b1 ; k = 1'b0 ;
		#5 //rst = 1 ;
		#2 j = 1'b1 ; k = 1'b1 ;
		#3 //rst = 0 ;
		#5 //rst = 1 ;
		#5 //rst = 1 ;
		#2 j = 1'b0 ; k = 1'b1 ;
		#3 //rst = 0 ;
		#3 //rst = 0 ;
		#3 j = 1'b1 ; k = 1'b0 ;
		#5 //rst = 1 ; 
		$finish ;
	end
endmodule 