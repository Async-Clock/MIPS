module mux(select, zero, one, out);
	
	parameter 					DATA_WIDTH = 1;
	
	input 						select;
	input 	[DATA_WIDTH-1:0] 	zero, one;
	output 	[DATA_WIDTH-1:0] 	out;
	
	assign out = select ? one : zero;
	
endmodule
