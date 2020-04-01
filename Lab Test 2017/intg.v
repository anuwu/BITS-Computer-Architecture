`timescale 1ms/1ns 

module tff (q, t, clk, clear) ;
	input t, clk, clear ;
	output reg q ;
	
	always @(posedge clk or posedge clear)
	begin
		if (clear)
			q <= 1'b0 ;
		else begin
			if (t == 0)
				q <= q ;
			else
				q <= ~q ;	
		end
	end
endmodule 

module counter4 (a, clk, clear) ;
	input clk, clear ;
	output[3:0] a ;
	
	wire w1, w2 ;
	
	tff t0 (a[0], 1'b1, clk, clear) ;
	tff t1 (a[1], a[0], clk, clear) ;
	
	and (w1, a[0], a[1]) ;
	tff t2 (a[2], w1, clk, clear) ;
	
	and (w2, w1, a[2]) ;
	tff t3(a[3], w2, clk, clear) ;
endmodule

module counter3 (a, clk, clear) ;
	input clk, clear ;
	output[2:0] a ;
	
	wire w1, w2 ;
	
	tff t0 (a[0], 1'b1, clk, clear) ;
	tff t1 (a[1], a[0], clk, clear) ;
	
	and (w1, a[0], a[1]) ;
	tff t2 (a[2], w1, clk, clear) ;
endmodule

module mux_small (out, sel, in0, in1) ;
	input in0, in1, sel ;
	output out ;
	
	assign out = (sel) ? in1 : in0 ;
endmodule

module mux_big (out, sel, in) ;
	input[7:0] in ;
	input[2:0] sel ;
	output out ;
	
	wire[3:0] w1 ;
	mux_small m10 (w1[0], sel[0], in[0], in[1]) ;
	mux_small m11 (w1[1], sel[0], in[2], in[3]) ;
	mux_small m12 (w1[2], sel[0], in[4], in[5]) ;
	mux_small m13 (w1[3], sel[0], in[6], in[7]) ;
	
	wire[1:0] w2 ;
	mux_small m20 (w2[0], sel[1], w1[0], w1[1]) ;
	mux_small m21 (w2[1], sel[1], w1[2], w1[3]) ;
	
	mux_small m3 (out, sel[2], w2[0], w2[1]) ;
endmodule

module memory (data, addr) ;
	input[3:0] addr ;
	output reg [7:0] data ;
	
	integer i ;
	
	reg[7:0] mem [15:0] ;
	initial begin
		mem[0] = 8'hCC ;
		mem[1] = 8'hAA ;
		mem[2] = 8'hCC ;
		mem[3] = 8'hAA ;
		mem[4] = 8'hCC ;
		mem[5] = 8'hAA ;
		mem[6] = 8'hCC ;
		mem[7] = 8'hAA ;
		mem[8] = 8'hCC ;
		mem[9] = 8'hAA ;
		mem[10] = 8'hCC ;
		mem[11] = 8'hAA ;
		mem[12] = 8'hCC ;
		mem[13] = 8'hAA ;
		mem[14] = 8'hCC ;
		mem[15] = 8'hAA ;
	end
	
	always @(addr) begin
		i = addr ;
		data = mem[i] ;
	end
endmodule
	

module intg (wave, clk1, clear) ;
	input clk1, clear ;
	output wave ;
	
	wire[2:0] a ;
	counter3 count3 (a, clk1, clear) ;
	
	wire clk2 ;
	and (clk2, a[2], a[1], a[0]) ;
	
	wire[3:0] b ;
	counter4 count4 (b, clk2, clear) ;
	
	wire[7:0] data ;
	memory m (data, b) ;
	
	mux_big mb (wave, a, data) ;
endmodule 



module tb ;
	reg clk1, clear ;
	wire wave ;
	
	integer i ;
	
	intg integrate (wave, clk1, clear) ;
	
	always #0.5 clk1 = ~clk1 ;
	
	initial begin
	clk1 = 0 ;
	clear = 0 ;
	
	$dumpfile ("plot.vcd") ;
	$dumpvars (0, tb) ;
	
	#0.1 clear = 1 ;
	#0.1 clear = 0 ;
	#0.3 ;
	for (i = 0 ; i < 100 ; i++) begin
	#1 ;
	end
	
	$finish ;
	
	
	end
endmodule






	
	
	