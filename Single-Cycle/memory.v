module memory(clk, MemWrite, MemRead, result, reg2, out);
	
	input 				clk, MemWrite, MemRead;
	input 		[31:0] 	result, reg2;
	output reg 	[31:0] 	out;

	reg 		[31:0] mem_a [31:0];
	
	integer i = 0;

// Initalize cache to zero
initial
begin
for (i = 0; i < 32; i = i + 1) begin
	mem_a[i] <= 0;
end
end

always @ (clk) begin

	if (MemWrite) 
		mem_a[result] <= reg2;
	
end

always @ (clk) begin

	if (MemRead) 
		out <= mem_a[result];

end
endmodule
