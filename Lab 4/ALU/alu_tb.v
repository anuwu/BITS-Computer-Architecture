`include "alu.v"

//module alu (result, carryout, a, b, op, binvert, carryin) ;

module ALU_tb ;
	reg binvert, carryin;
	reg [1:0] op;
	reg [31:0] a,b;
	wire [31:0] result;
	wire carryout;
	
	alu aloo (result,carryout,a, b, op, binvert,carryin);
	initial begin
		$monitor ("result = %d carryout = %b \na = %d b = %d carryin=%b \nop=%2b binvert = %b\n-----------\n\n", result, carryout, a, b, carryin, op, binvert) ;
	
		a = 45653966;
		b = 36489465;
		
		op = 2'b00;
		binvert = 1'b0;
		carryin = 1'b0;
		
		#100 op = 2'b00 ; //AND
		#100 op = 2'b01 ; //OR
		#100 op = 2'b10 ; //ADD
		#100 binvert = 1'b1 ; carryin = 1'b1 ;//SUB
		#200 $finish;
	end
endmodule