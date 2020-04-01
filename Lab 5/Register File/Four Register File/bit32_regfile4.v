`include "bit32_reg.v"
`include "dec2to4.v"
`include "mux4to1.v"

//module bit32_reg (dat, clk, rst, inp) ;
//module dec2to4 (out, in) ;
//module mux4to1 (out, sel, in0, in1, in2, in3) ;

module bit32_regfile4 (read1, read2, read_addr1, read_addr2, write_addr, write_dat, regwrite, clk, rst) ;

	input [1:0] read_addr1, read_addr2, write_addr ;
	input regwrite, clk, rst ;
	input [31:0] write_dat ;
	output [31:0] read1, read2 ;
	
	wire[3:0] dec_out ;
	wire cg0, cg1, cg2, cg3 ;
	wire[31:0] dat0, dat1, dat2, dat3 ;
	
	dec2to4 dec (dec_out, write_addr) ;
	and (cg0, clk, regwrite, dec_out[0]) ;
	and (cg1, clk, regwrite, dec_out[1]) ;
	and (cg2, clk, regwrite, dec_out[2]) ;
	and (cg3, clk, regwrite, dec_out[3]) ;
	
	bit32_reg r0 (dat0, cg0, rst, write_dat) ;
	bit32_reg r1 (dat1, cg1, rst, write_dat) ;
	bit32_reg r2 (dat2, cg2, rst, write_dat) ;
	bit32_reg r3 (dat3, cg3, rst, write_dat) ;
	
	mux4to1 mr1 (read1, read_addr1, dat0, dat1, dat2, dat3) ;
	mux4to1 mr2 (read2, read_addr2, dat0, dat1, dat2, dat3) ;
	
endmodule