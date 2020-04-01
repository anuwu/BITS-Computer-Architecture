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