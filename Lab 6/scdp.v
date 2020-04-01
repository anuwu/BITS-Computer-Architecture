`include "ALU_32Bit.v"
`include "ALU_Control_Unit.v"
`include "Concat_32Bit.v"

`include "DataMemory_32_32Bit.v"
`include "FullAdder_32Bit.v"
`include "InstructionMem_32_32Bit.v"

`include "Main_Control_Unit_PLA.v"
`include "MUX_2To1_5Bit.v"
`include "MUX_32Bit_4To1.v"

`include "32RegisterFile_32Bit.v"
`include "SignExtender_32Bit.v"
`include "ShiftLeft32.v"
`include "ShiftLeft26.v"



/*
module  ALU32Bit(Zero, CarryOut, Result, A, B, Op);
module  ALUControlUnit(Op, Func, ALUOp);
  
module concatJuPC(out, J, PC);

module Data_Memory(Clock, MemRead, ReadAddress, ReadData, MemWrite, WriteAddress, WriteData);
module FADDER32(carry, sum, A, B, CarryIn);
module Instruction_Memory(Inst, PC, clock);

module  MainControlUnit(RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1, Op);
module MUX5Bit_2To1(out, select, q1, q2);
module  Mux32Bit_2To1(out, select, in1, in2);

module RegFile_32(ReadData1, ReadData2, Clock, Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData);
module Sign_Extender(out, in) ;
module ShiftLeft32(out, in);
module ShiftLeft26(out, in);
*/

module scdp (ALUOutput, PC_start, reset, clock); 
	input[31:0] PC_start ;
	input reset, clock ;
	output[31:0] ALUOutput ;
	reg[31:0] PC ;
	
	initial begin 
	PC = PC_start ; 
	end
	
	
	/* ------------------------------------------------------ IF ------------------------------------------------------*/
	wire [31:0] Inst ;
	Instruction_Memory IM (Inst, PC, clock) ;
	
	/* ------------------------------------------------------ IF ------------------------------------------------------*/
	
	/*******************************************************************************************************************/
	/*******************************************************************************************************************/
	
	/* ------------------------------------------------------ ID ------------------------------------------------------*/
	
	//Control Unit
	wire RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1 ;
	wire [2:0] ALUCUOUT ;
	MainControlUnit MCU (RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1, Inst[31:26]) ;
	ALUControlUnit ALUCU (ALUCUOUT, Inst[5:0], {ALUOP0, ALUOP1}) ;
	
	//Inputs to RF
	wire [4:0] write_addr ; 
	MUX5Bit_2To1 rf_read2 (write_addr, RegDst, Inst[20:16], Inst[15:11]) ;
	wire [31:0] AluOp1, AluOp2_R ;
	wire [31:0] final_out ;			//Just before write_back stage
	
	//module RegFile_32(ReadData1, ReadData2, Clock, Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData);
	RegFile_32 RF (AluOp1, AluOp2_R, Clock, Reset, RegWrite, Inst[25:21], Inst[20:16], write_addr, final_out) ;
	
	//Inputs to ALU
	wire[31:0] AluOp2_off, AluOp2 ;
	Sign_Extender SE (AluOp2_off, Inst[15:0]) ;
	Mux32Bit_2To1 M32_Pre_Alu (AluOp2, ALUSrc, AluOp2_R, AluOp2_off);
	
	/* ------------------------------------------------------ ID ------------------------------------------------------*/
	
	/*******************************************************************************************************************/
	/*******************************************************************************************************************/
	
	/* ------------------------------------------------------ EX ------------------------------------------------------*/
	
	wire carry_out_aloo , zero ;
	wire[31:0] alu_result ;
	ALU32Bit aloo (zero, carry_out_alu, alu_result, AluOp1, AluOp2, ALUCUOUT) ;
	
	
	/* ------------------------------------------------------ EX ------------------------------------------------------*/
	
	/*******************************************************************************************************************/
	/*******************************************************************************************************************/
	
	/* ------------------------------------------------------ MEM ------------------------------------------------------*/
	
	//module Data_Memory(Clock, MemRead, ReadAddress, ReadData, MemWrite, WriteAddress, WriteData);
	wire [31:0] DM_out ;
	Data_Memory DM (clock, MemRead, alu_result, DM_out, MemWrite, alu_result, AluOp2_R) ;
	Mux32Bit_2To1 write_back (final_out, MemToReg, alu_result, DM_out) ;
	
	/* ------------------------------------------------------ MEM ------------------------------------------------------*/
	
	//Write back stage ---> Check the last argument of RF module
	
	/*******************************************************************************************************************/
	/*******************************************************************************************************************/
	
	
	/* ------------------------------------------------------ TOP_ADDRESS ------------------------------------------------------*/
	
	wire [31:0] final_addr_out ;
	
	//Plus plus four
	wire[31:0] PC_plus4 ;
	wire carry_out_pc_plus_4 ;		//shift to top_part block
	FADDER32 FA_PC_plus4 (carry_out_plc_plus_4, PC_plus4, PC, 32'b00000000_00000000_00000000_00000100, 1'b0) ;		//shift to top_part_block
	
	//Jump address
	wire[27:0] ja28 ;
	wire[31:0] jump_addr ;
	ShiftLeft26 sh26 (ja28 , Inst[25:0]) ;
	concatJuPC PC_dot_jump (jump_addr, ja28, PC_plus4) ;
	
	//Conditional branch address
	wire[31:0] AluOp2_offshift ;
	wire[31:0] branch_addr ;
	wire carry_out_branch_addr ;
	ShiftLeft32 sh32 (AluOp2_offshift , AluOp2_off) ;
	FADDER32 FA_branch_address (carry_out_branch_addr, branch_addr , PC_plus4, AluOp2_offshift, 1'b0) ;
	
	//Muxes for final_addr_out
	wire addr_mux1_sel ;
	wire [31:0] addr_post_m1 ;
	and (addr_mux1_sel, zero, Branch) ;
	Mux32Bit_2To1 mux_addr1 (addr_post_m1, addr_mux1_sel, PC_plus4, branch_addr) ;
	Mux32Bit_2To1 mux_addr2 (final_addr_out, Jump, addr_post_m1, jump_addr)  ;
	
	/* ------------------------------------------------------ TOP_ADDRESS ------------------------------------------------------*/
	
	always @(posedge clock) begin
		PC <= final_addr_out ;		
	end
endmodule 




module TBSCDataPath;
  reg clock, reset;
  reg [31:0]  PC_start;
  wire  [31:0]  ALUOutput ;
  scdp processor(ALUOutput, PC_start;, reset, clock);
  initial begin
    $monitor($time, " :PC = %b, Reset = %b, Clock = %b, NextPC = %b, ALUOutput = %b.", PC, reset, clock, PCCurrent, ALUOutput);
    #0  clock = 1'b0; PC = 32'd20; reset = 1'b0;
    #15 reset = 1'b1;
    #10 PC_start = 32'd12;
    #40 PC = PCCurrent;
    #40 PC = PCCurrent;
    #50 $finish;
  end
  always  begin
    #10 clock = ~clock;
  end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	