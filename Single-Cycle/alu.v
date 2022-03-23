module alu(reg1, reg2, opcode, result);
	
	input 		[31:0]	reg1, reg2;
	input 		[3:0]	opcode;
	output reg 	[31:0]  result;


always @ (reg1 or reg2 or opcode) begin
	case (opcode)

		4'b0000: result <= reg1 & reg2;
		4'b0001: result <= reg1 | reg2;
		4'b0010: result <= reg1 + reg2;
		4'b0110: result <= reg1 - reg2;
		4'b1100: result <= ~(reg1 | reg2);
		4'b1101: result <= ~(reg1 & reg2);
		4'b0111: begin
					if (reg1 < reg2)
						result <= 1;
				 	else
						result <= 0;
				 end
	endcase
end
endmodule
