module alucontrol(funct, aluop, opcode);
	
	input 		[5:0] funct;
	input 		[1:0] aluop;
	output reg 	[3:0] opcode;

always @ (funct or aluop) begin

	case (aluop)

		2'b00: opcode <= 4'b0010;
		2'b10: begin
				case (funct)
					6'b100000: opcode <= 4'b0010;
					6'b100010: opcode <= 4'b0110;
					6'b100100: opcode <= 4'b0000;
					6'b100101: opcode <= 4'b0001;
					6'b100111: opcode <= 4'b1100;
					6'b101010: opcode <= 4'b0111;
					6'b100110: opcode <= 4'b1101;
					endcase
				end
		endcase
	end
endmodule
