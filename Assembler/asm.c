#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "asm.h"

int main(int argc, char** argv) {

	char* filename;
	char* outfile;
	// Command line argument handling
	if (argc == 1)
	{
		filename = "asm.txt";
		outfile  = "asm.out";
	}
	else if (argc == 2)
	{
		filename = argv[1];
		outfile  = "asm.out";
	}
	else if (argc == 3)
	{
		filename = argv[1];
		outfile  = argv[2];
	}
	
	
	FILE *fp;
	FILE *out;
	fp = fopen(filename, "r");
	out = fopen(outfile, "w");
	
	char buffer [100];
	char tok_buffer [20][4];
	while (fgets(buffer, sizeof(buffer), fp))
	{
		char* token = strtok(buffer, " ");

		int count = 0;
		// Tokenize assembly instructions
		while (token != NULL)
		{
			strcpy(tok_buffer[count], token);
			token = strtok(NULL, " ");
			count = count + 1;
		}
		// Calls either I or R type function depending on instruction
		if      (!strncmp(tok_buffer[0], "ADD", 4))  	rtype(tok_buffer, out, 0);
		else if (!strncmp(tok_buffer[0], "ADDI", 4)) 	itype(tok_buffer, out, 1);
		else if (!strncmp(tok_buffer[0], "AND", 4)) 	rtype(tok_buffer, out, 2);
		else if (!strncmp(tok_buffer[0], "ANDI", 4)) 	itype(tok_buffer, out, 6);
		else if (!strncmp(tok_buffer[0], "OR", 4))   	rtype(tok_buffer, out, 4);
		else if (!strncmp(tok_buffer[0], "SUB", 4)) 	rtype(tok_buffer, out, 5);
		else if (!strncmp(tok_buffer[0], "ORI", 4)) 	itype(tok_buffer, out, 7);
		else if (!strncmp(tok_buffer[0], "XORI", 4)) 	rtype(tok_buffer, out, 8);
		memset(buffer, 0, 100);
		memset(tok_buffer, 0, 80);
	}
	
	fclose(fp);
    fclose(out);
    return 0;
    
}
