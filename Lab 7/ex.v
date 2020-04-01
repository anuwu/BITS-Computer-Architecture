module state_register (S, NS, clk, reset) ;
	input clk, reset ;
	input[3:0] NS ;
	output reg[3:0] S ;
	
	always @(posedge reset or negedge reset)
	begin
		if (!reset)
			S <= 4'b0000 ;
		else
			S <= NS ;
	end
endmodule

module control_logic (PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, S, opcode) ;
	input[3:0] S ;
	input[5:0] opcode ;
	output PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst ;
	output[1:0] PCSource, ALUOp, ALUSrcB ;
	output[3:0] NS ;
	
	wire[0:16] w ;
	
	assign w[0] = (~S[3]) & (~S[2]) & (~S[1]) & (~S[0]) ;
	assign w[1] = (~S[3]) & (~S[2]) & (~S[1]) & (S[0]) ;
	assign w[2] = (~S[3]) & (~S[2]) & (S[1]) & (~S[0]) ;
	assign w[3] = (~S[3]) & (~S[2]) & (S[1]) & (S[0]) ;
	assign w[4] = (~S[3]) & (S[2]) & (~S[1]) & (~S[0]) ;
	assign w[5] = (~S[3]) & (S[2]) & (~S[1]) & (S[0]) ;
	assign w[6] = (~S[3]) & (S[2]) & (S[1]) & (~S[0]) ;
	assign w[7] = (~S[3]) & (S[2]) & (S[1]) & (S[0]) ;
	assign w[8] = (S[3]) & (~S[2]) & (~S[1]) & (~S[0]) ;
	assign w[9] = (S[3]) & (~S[2]) & (~S[1]) & (S[0]) ;
	assign w[10] = ~(S[3]) & (~S[2]) & (~S[1]) & (S[0]) & (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (opcode[1]) & (~opcode[0]);
	assign w[11] = ~(S[3]) & (~S[2]) & (~S[1]) & (S[0]) & (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (~opcode[1]) & (~opcode[0]); 
	assign w[12] = ~(S[3]) & (~S[2]) & (~S[1]) & (S[0]) & (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]);
	assign w[13] = ~(S[3]) & (~S[2]) & (S[1]) & (~S[0]) & (opcode[5]) & (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]);
	assign w[14] = ~(S[3]) & (~S[2]) & (~S[1]) & (S[0]) & (opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]);
	assign w[15] = ~(S[3]) & (~S[2]) & (~S[1]) & (S[0]) & (opcode[5]) & (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]);
	assign w[16] = ~(S[3]) & (~S[2]) & (S[1]) & (~S[0]) & (opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]);
	
	
	assign PCWrite = (w[0])| (w[9]) ;
	assign PCWriteCond = w[8];
	assign IorD = (w[3])| (w[5]) ;
	assign MemRead = (w[0])| (w[3]) ;
	assign MemWrite = w[5] ;
	assign IRWrite = w[0] ;
	assign MemtoReg = w[4] ;
	
	assign PCSource[1] = w[9] ;
	assign PCSource[0] = w[8] ;
	assign ALUOp[1] = w[7] ;
	assign ALUOp[0] = w[8] ;
	assign ALUSrcB[1] = (w[1])| (w[2]) ;
	assign ALUSrcB[0] = (w[0])| (w[1]) ;
	
	assign ALUSrcA = (w[2]) | (w[6]) | (w[8]) ;
	assign RegWrite = (w[4]) | (w[7]) ;
	assign RegDst = w[7] ;
	
	assign NS[3] = w[10] | w[11];
	assign NS[2] = w[12] | w[13] | w[3] | w[6] ;
	assign NS[1] = w[6] | w[12] | w[14] | w[15] | w[16] ;
	assign NS[0] = w[16] | w[13] | w[10] | w[6] | w[0] ;
endmodule 

module controller (PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, opcode, clk, reset) ;
	input clk, reset ;
	input[5:0] opcode ;
	output PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst ;
	output[1:0] PCSource, ALUOp, ALUSrcB ;
	wire[3:0] S, NS ;

	control_logic cl (PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, S, opcode) ;
	state_register stat (S, NS, clk, reset) ;
endmodule 

module controller_tb ;
	reg clk, reset ;
	reg[5:0] opcode ;
	
	wire PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst ;
	wire[1:0] PCSource, ALUOp, ALUSrcB ;
	controller cont (PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, opcode, clk, reset) ;
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 0 ;
		reset = 1 ;
		opcode = 6'b000000 ;
		
		$monitor ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		$dumpfile ("ex.vcd") ;
		$dumpvars (0, controller_tb) ;
		 
		#1 reset = 0 ;
		#1 reset = 1 ;
		#3 opcode = 6'b000000 ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 opcode = 6'b100011 ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 opcode = 6'b101011 ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 opcode = 6'b000100 ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 ; $display ($time, " State = %d , Opcode = %b" , cont.S, opcode) ;
		#10 opcode = 6'b000010 ; $finish ;
	end
endmodule 
