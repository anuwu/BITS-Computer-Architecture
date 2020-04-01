module reg1(EN, in, CLK, Q);
parameter n = 4; 
input EN; 
input in; 
input CLK; 
output [n-1:0] Q; 
reg [n-1:0] Q;

initial Q = 4'b0101 ;
always @(posedge CLK) 
begin 
	if (EN) 
		Q={in,Q[n-1:1]}; 
		end 
		
endmodule