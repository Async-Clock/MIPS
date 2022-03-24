# Assembler
This repo contains a simple, self made assembler that supports a small subset of assembly instructions. The project was made for the purpose of creating test vectors for a MIPS CPU.
# Inputs
The program reads an assembly file (defaults to asm.txt). This can be modified by passing in the desired filename as an argument. The program can take up to two arguments from the user, for both the input file name and the output file name. The program expects the input file as the first argument in the case specifying both the input and output file. 
## Input Assembly Format
The assembler was designed to take assembly input in the form of:
	
    ADD $1, $2, $3

Using register names such as $t0 or $s1 is not supported.
# Outputs
The program outputs machine code to either the default asm.out or the file specified by the second argument passed in from the command line. 