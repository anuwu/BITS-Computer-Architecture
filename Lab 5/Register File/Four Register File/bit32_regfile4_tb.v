`include "bit32_regfile4.v"

//module bit32_regfile4 (read1, read2, read_addr1, read_addr2, write_addr, write_dat, regwrite, clk, rst) ;

module bit32_regfile4_tb ;
	reg[31:0] write_dat ;
	reg[1:0] read_addr1, read_addr2, write_addr ;
	reg regwrite, clk, rst ;
	wire[31:0] read1, read2 ;
	
	integer wi , ri ;
	
	bit32_regfile4 RF4 (read1, read2, read_addr1, read_addr2, write_addr, write_dat, regwrite, clk, rst) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		rst = 1 ;
		
		
		$dumpfile ("bit32_regfile4_tb.vcd") ;
		$dumpvars (0, bit32_regfile4_tb) ;
		
		#1 rst = 0 ;
		#1 rst = 1 ;
		#3 regwrite = 1 ; write_addr = 0 ; write_dat = 100 ;
		#10 regwrite = 0 ; $finish ;
		
		/*
		for (wi = 0 ; wi < 4 ; wi++)
		begin
			write_addr = wi ;
			write_dat = wi**4 + wi**3 + wi**2 + wi + 1 ;
			$display ("write_addr = %d, write_dat = %d\n", write_addr, write_dat) ;
			#10 ;
		end
		
		#0 regwrite = 0 ;
		
		for (ri = 0 ; ri < 4 ; ri++)
		begin
			read_addr1 = ri ;
			read_addr2 = (ri**4)%4 ;
			$display ("read_addr1=%d, read1 = %d, read_addr2 = %d, read2 = %d\n", read_addr1, read1, read_addr2, read2) ;
			#10 ;
		end
		
		read_addr1 = 0 ;
		$display ("read_addr1=%d, read1 = %d", read_addr1, read1) ;
		*/
	
	end
endmodule 
	
	