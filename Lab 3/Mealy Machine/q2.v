module ozooz (out, inp, clk, rst) ;
	output out ;
	input inp, clk, rst ;
	
	reg [2:0] state ;
	reg out ;
	
	//Uncomment line below if you want initial state to be pre-defined
	//initial begin state <= 3'b000 ; out = 1'b0 ; end
	
	always @(posedge clk or posedge rst)
	begin
		if (rst) begin
			state <= 3'b000 ;
			out <= 1'b0 ;
		end
		else begin
			case (state)
			3'b000 : begin
				if (inp) begin
					state <= 3'b001 ;
					out <= 1'b0 ;
				end
				else begin
					state <= 3'b000 ;
					out <= 1'b0 ;
				end
			end
			
			3'b001 : begin
				if (inp) begin
					state <= 3'b001 ;
					out <= 1'b0 ;
				end
				else begin
					state <= 3'b010 ;
					out <= 1'b0 ;
				end
			end
			
			3'b010 : begin
				if (inp) begin
					state <= 3'b011 ;
					out <= 1'b0 ;
				end
				else begin
					state <= 3'b000 ;
					out <= 1'b0 ;
				end
			end
			
			3'b011 : begin
				if (inp) begin
					state <= 3'b100 ;
					out <= 1'b0 ;
				end
				else begin
					state <= 3'b010 ;
					out <= 1'b0 ;
				end
			end
			
			3'b100 : begin
				if (inp) begin
					state <= 3'b001 ;
					out <= 1'b0 ;
				end
				else begin
					state <= 3'b010 ;
					out <= 1'b1 ;
				end
			end
			
			default: begin
				state <= 3'b000 ;
				out <= 0 ;
			end
			
			endcase
			
		end
	end
endmodule