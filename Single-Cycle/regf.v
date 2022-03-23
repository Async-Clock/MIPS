module regfile(clk, regwrite, ra1, ra2, wa, write_data, reg1, reg2);
 	
 	input 				clk, regwrite;
 	input 		[4:0] 	ra1, ra2, wa; 	//register address 1, register address 2, write address
 	input 		[31:0] 	write_data; 	//data to be written on writeback stage
 	output reg 	[31:0] 	reg1, reg2; 	//contents of registers at address 1 and 2
 	
 	reg [31:0] r[31:0]; 				//register file

	integer i = 0;

// Initalize the register file to 0's
initial
begin
for (i = 0; i < 32; i = i + 1) begin
	r[i][31:0] <= 32'b0;
end
end

always @ (clk) begin
		
 		reg1 <= r[ra1]; 	
 		reg2 <= r[ra2];

end

always @ (clk) begin
	if (regwrite == 1)
 		r[wa][31:0] <= write_data;
end
endmodule
