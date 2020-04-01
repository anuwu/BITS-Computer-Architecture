/*

For use in Shift Adder exercise, I had used an extra input argument -
input [n-1:0] init 

Using assign in the initial block did not work. Hence I ditched the idea.

*/

module shiftreg(EN, in, CLK, Q);
parameter n = 4; 
input EN; 
input in; 
input [n-1:0] init ;
input CLK; 
output [n-1:0] Q; 
reg [n-1:0] Q;

initial Q = 4'b0000 ;

always @(posedge CLK) 
begin 
	if (EN) 
		Q={in,Q[n-1:1]}; 
end 
		
endmodule