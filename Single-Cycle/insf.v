module insf(w_r, clk, pc, instruction_store, instruction);

// Instruction fetch module
	
	input 				w_r, clk;
	input 		[7:0] 	pc;
	input 		[31:0] 	instruction_store;
	output reg 	[31:0] 	instruction;

reg [31:0] mem_a [255:0];

always @ (posedge clk) begin

	if (w_r == 0) 
		instruction <= mem_a[pc];
	else
		mem_a[pc] <= instruction_store;
	
end
endmodule
