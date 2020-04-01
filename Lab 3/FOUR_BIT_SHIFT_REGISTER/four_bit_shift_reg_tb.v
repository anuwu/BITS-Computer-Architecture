`include "four_bit_shift_reg.v"

module shiftregtest;
	parameter n= 4; 
	reg EN,in , CLK; 
	wire [n-1:0] Q;
	
	shiftreg shreg(EN,in,CLK,Q);
	
	always #2 CLK=~CLK;
	initial begin 
			$monitor($time,"CLK=%b EN=%b in= %b Q=%4b\n",CLK,EN,in,Q); 
			$dumpfile ("four_bit_shift_reg_tb.vcd") ;
			$dumpvars (0, shiftregtest) ;
			
			CLK=0 ;
			in=0;
			EN=0;

			#4 in=1;EN=1;
			#4 in=1;EN=0; 
			#4 in=0;EN=1;
			#5 $finish; 
	end 
endmodule