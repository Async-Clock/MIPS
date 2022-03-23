module signex(in, out);
	
	// Sign extend module
	
	input 	[15:0] in;
	output 	[31:0] out;

	assign out = { {16{in[15]}}, in[15:0] };

endmodule
