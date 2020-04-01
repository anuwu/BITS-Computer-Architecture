module MUX5Bit_2To1(out, select, q1, q2);
	input  [4:0] q1, q2;
	input select;
	output [4:0] out;
	genvar  j;
  generate  for(j = 0; j < 5; j = j + 1)  
    begin:  mux_loop
      Mux2To1 Mux(out[j], select, q1[j], q2[j]);
    end
  endgenerate
endmodule