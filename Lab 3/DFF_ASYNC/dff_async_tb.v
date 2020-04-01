`include "dff_async.v"

module testbench ;
	reg d, clk, rst;
	wire q ;
	
	dff_async dff (d, rst, clk, q) ;

	always #5 clk = ~clk ;

	initial begin
		d = 0 ;
		clk = 0 ;
		rst = 1 ;
		$monitor($time , "d=%b, clk=%b, rst=%b, q=%b\n", d, clk, rst, q);
		$dumpfile ("dff_async.vcd") ;
		$dumpvars (0 , testbench) ;
		
		#5 d = 1'b1 ;
		#5 d = 1'b1 ;
		#5 d = 1'b0 ;
		#3 rst = 0 ;
		#5 d = 1'b1 ;
		#5 rst = 1 ;
		#3 rst = 0 ;
		#5 rst = 1 ;
		#3 rst = 0 ;
		#5 rst = 1 ;
		#3 rst = 0 ;
		#5 rst = 1 ;
		#2 d = 1'b1 ;
		#3 rst = 0 ;
		#5 rst = 1 ;
		#5 rst = 1 ;
		#2 d = 1'b0 ;
		#3 rst = 0 ;
		#3 rst = 0 ;
		#3 rst = 0 ;
		#5 rst = 1 ; 
		$finish ;
	end
endmodule