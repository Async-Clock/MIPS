module pc(clk, reset, addr);
	
	input 				clk, reset;
	output reg 	[7:0] 	addr;

always @ (posedge clk or posedge reset) begin

	if (reset) 
		addr <= 8'b0;
	else 
		addr <= addr + 1;

end
endmodule
