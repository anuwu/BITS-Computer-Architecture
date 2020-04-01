`include "q2.v"

module testbench ;
	reg inp, clk, rst ;
	reg [10:0] seq ;
	wire out ;
	integer i ;
	
	ozooz mealy (out, inp, clk, rst) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		$dumpfile ("q2_tb.vcd") ;
		$dumpvars (0 , testbench) ;
		clk = 0 ;
		rst = 0 ;
		seq = 11'b10110110101 ;
		
		//Resetting device
		#1 rst = 1 ;
		#2 rst = 0 ;
		
		#2 ;
		for (i = 0 ; i <= 10 ; i = i + 1)
		begin
			inp = seq[i] ;
			$display ("State = ", mealy.state, " Input = ", inp, " Output = ", out, "\n") ;
			
			if (i == 3) begin
				#6 rst = 0 ;
				#1 rst = 0 ;
				#3 ;
			end
			else	#10 ;
		end
		
		#0 $finish ;
	end
endmodule