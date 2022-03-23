module control(
				instruction,
				RegDst,
				MemRead,
				MemtoReg,
				ALUOp,
				MemWrite,
				ALUSrc,
				RegWrite);

	
	input 		[5:0] 	instruction;
	
	output reg 			RegDst, MemRead, MemtoReg,
			 			MemWrite, ALUSrc, RegWrite;
	output reg 	[1:0] ALUOp;


always @ (instruction) begin
	case (instruction)
	
		0: begin
			RegDst = 1;
			RegWrite = 1;
			ALUSrc = 0;
			MemtoReg = 0;
			MemRead = 0;
			MemWrite = 0;
			ALUOp = 2'b10;
			end
		35: begin
			RegDst = 0;
			MemWrite = 0;
			ALUSrc = 1;
			MemtoReg = 1;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 1;
			ALUOp = 2'b0;
			end
		43: begin
			ALUSrc = 1;
			MemWrite = 1;
			RegWrite = 0;
			MemRead = 0;
			ALUOp = 2'b0;
			end
		8: begin
			RegDst = 0;
			MemtoReg = 0;
			MemRead = 0;
			MemWrite = 0;
			ALUSrc = 1;
			RegWrite = 1;
			ALUOp = 2'b0;
			end
	endcase
end
endmodule
