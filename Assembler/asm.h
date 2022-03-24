#include <ctype.h>
/*
	
	Function handles converting decimal 
	numbers into binary
	
*/
void binary_decimal(int decimal, int size, FILE *out) 
{
	int k;
	size -= 1;
	for (size; size >= 0; size--) 
	{
		k = decimal >> size;
		
		if (k & 1) 
		{
			fprintf(out, "1");
		}
		else 
		{
			fprintf(out, "0");
		}
	}
}
/*

	Function to handle printing out the binary for the 
	registers
	
	type 0 = rtype, 1 = itype

*/
void register_print(char tok_buffer[][4], FILE *out, int type) 
{
	int addr, str_len, num, digit, x;
	
	if (type == 0) 
	{
		addr = tok_buffer[2][1] - '0';
    	binary_decimal(addr, 5, out);
    	addr = tok_buffer[3][1] - '0';
    	binary_decimal(addr, 5, out);
    	addr = tok_buffer[1][1] - '0';
		binary_decimal(addr, 5, out);
	}
	else if (type == 1) 
	{
		addr = tok_buffer[2][1] - '0';
		binary_decimal(addr, 5, out);
		addr = tok_buffer[1][1] - '0';
		binary_decimal(addr, 5, out);
		
		str_len = strlen(tok_buffer[3]);
		num = 0;
		for (x=0; x<str_len; x++)
		{
			if (isdigit(tok_buffer[3][x]))
			{
				/* 
				*  Subtracting the character '0' from a digit stored in type char
				*  will yield the integer value of that digit
				*/
				digit = tok_buffer[3][x] - '0';
				num = num * 10 + digit;
				printf("%d, %d\n", num, digit);
			}
		}
		binary_decimal(num, 16, out);
	}
}
/*
    
	000000 00000 00000 00000 00000 000000
	op     rs    rt    rd    shift funct

*/
void rtype(char tok_buffer[][4], FILE *out, int code) 
{
	printf("R type\n");
	fprintf(out, "000000");
    register_print(tok_buffer, out, 0);
	switch(code) 
	{
		case 0: fprintf(out, "00000100000\n"); //ADD
				break;
		case 2: fprintf(out, "00000100100\n"); //AND
				break;
		case 4: fprintf(out, "00000100101\n"); //OR
				break;
		case 5: fprintf(out, "00000100010\n"); //SUB
				break;
		default: printf("Code not supported/formatted incorrectly\n");
	}
	
}

/*

	000000 00000 00000 0000000000000000
	opcode rs    rt    imm
	
*/

void itype(char tok_buffer[][4], FILE *out, int code) 
{
	int imm, addr;
	printf("I type\n");
	switch(code) 
	{
		case 1: fprintf(out, "001000"); //ADDI
				break;
		case 6: fprintf(out, "001100"); //ANDI
				break;
		case 7: fprintf(out, "001101"); //ORI
				break;
		case 8: fprintf(out, "001110"); //XORI
				break;
	}
	register_print(tok_buffer, out, 1);
	fprintf(out, "\n");
}
