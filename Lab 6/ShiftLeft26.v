module ShiftLeft26(out, in);
	input [25:0] in;
	output [27:0] out;
	assign out = {in,1'b0,1'b0};
endmodule