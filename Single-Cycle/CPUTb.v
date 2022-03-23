module CPUTb();
	
	reg 			clk, w_r, reset;
	reg 	[31:0] 	in;
	wire 			RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	wire 	[1:0] 	ALUOp;
	wire 	[3:0] 	opcode;
	wire 	[4:0] 	WriteReg;
	wire 	[7:0] 	addr;
	wire 	[31:0] 	ins, extended, ALUIn, result, reg1, reg2, out, wb;
	


/* 
*
*  Module Instances
*
*  Verilator will throw errors unless parameter overrides are in the form:
*		module #(.*PARAM_NAME* (*value*)) instance(*ports*);
*/

pc pc1(								.clk(clk), 
									.reset(reset),
									.addr(addr));

insf mem1(							.clk(clk), 
									.pc(addr), 
									.w_r(w_r), 
									.instruction_store(in),
									.instruction(ins));

control control1(					.instruction(ins[31:26]),
									.RegDst(RegDst),
									.ALUSrc(ALUSrc),
									.MemtoReg(MemtoReg), 
									.RegWrite(RegWrite), 
									.MemRead(MemRead), 
									.MemWrite(MemWrite), 
									.ALUOp(ALUOp));

mux #(.DATA_WIDTH (5)) mux_fivebit (	.zero(ins [20:16]), 
									.one(ins [15:11]), 
									.select(RegDst), 
									.out(WriteReg));

regfile regfile1(					.clk(clk),
									.regwrite(RegWrite),
									.ra1(ins[25:21]), 
									.ra2(ins[20:16]),
									.write_data(wb),
									.wa(WriteReg),
									.reg1(reg1), 
									.reg2(reg2));

signex signex1(						.in(ins[15:0]), 
									.out(extended));

mux #(.DATA_WIDTH (32)) mux_32_1(		.zero(reg2), 
									.one(extended), 
									.select(ALUSrc), 
									.out(ALUIn));

alu alu1(							.reg1(reg1), 
									.reg2(ALUIn),
									.opcode(opcode),
									.result(result));

alucontrol alucontrol1(				.funct(ins[5:0]),
									.aluop(ALUOp),
									.opcode(opcode));

memory mem2(						.clk(clk), 
									.result(result), 
									.MemWrite(MemWrite),
									.MemRead(MemRead),
									.reg2(reg2),
									.out(out));

mux #(.DATA_WIDTH (32)) mux_32_2(	.zero(result),
									.one(out),
									.select(MemtoReg), 
									.out(wb));

initial begin
	reset = 1;
	#5
	reset = 0;
	#5
	clk = 0;
	reset = 0;
	in = 32'b00100000001000010000000000000001;//instruction 1
	w_r = 1;
	#10 in = 32'b00100000010000100000000000000011;//instruction 2
	#10 in = 32'b00000000001000010000100000100000;//instruction 3
	#10 in = 32'b00000000010000100001100000100000;//instruction 4
	#10 in = 32'b00000000011000110001100000100000;//instruction 5
	#10 in = 32'b00000000011000100001100000100000;//instruction 6
	#10 in = 32'b00000000011000010001100000100000;//instruction 7
	#10 in = 32'b10101100000000110000000000000000;//instruction 8
	#10 in = 32'b10001100000001000000000000000000;//instruction 9
	#10 w_r = 0;
	reset = 1;
	#10 reset = 0;
	#200 $finish;
end
always #5 clk = ~clk;
endmodule
