module  ALU32Bit(Zero, CarryOut, Result, A, B, Op);
  input [2:0] Op;
  input [31:0] A, B;
  output [31:0] Result;
  reg [31:0] Result;
  output CarryOut, Zero;
  reg CarryOut;
  assign Zero = (({Result} == 0)) ? 1 : 0;
  always @ (Op, A, B) begin
    case(Op)
      0:  Result <= A & B;
      1:  Result <= A | B;
      2:  {CarryOut, Result[31:0]} <= A + B;
      6:  {CarryOut, Result[31:0]} <= A - B;
      7:  Result <= A < B ? 1 : 0;
      default: Result <= 0;
    endcase
  end
endmodule