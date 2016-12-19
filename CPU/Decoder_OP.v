`define OP_ADD 5'b00000 // Add
`define OP_ADDI 5'b00001 // Add immediate
`define OP_MOV 5'b00010 // Move
`define OP_MOVI 5'b00011 // Move immediate
`define OP_SUB 5'b00100 // Subtract
`define OP_SUBI 5'b00101 // Subtract immediate
`define OP_SHL 5'b00110 // Shift Left
`define OP_SHLI 5'b00111 // Shift Left immediate
`define OP_SHAR 5'b01000 // Arithmetic Shift Right
`define OP_SHARI 5'b01001 // Arithmetic Shift Right immediate
`define OP_SHLR 5'b01010 // Logical Shift Right
`define OP_SHLRI 5'b01011 // Logical Shift Right immediate
`define OP_RL 5'b01100 // Rotate Left
`define OP_RLI 5'b01101 // Rotate Left immediate
`define OP_RR 5'b01110 // Rotate Right
`define OP_RRI 5'b01111 // Rotate Right immediate
`define OP_AND 5'b10000 // AND
`define OP_ANDI 5'b10001 // AND immediate
`define OP_OR 5'b10010 // OR
`define OP_ORI 5'b10011 // OR immediate
`define OP_NOT 5'b10110 // NOT
`define OP_MULT 5'b11000 // Multiply
`define OP_MULTI 5'b11001 // Multiply immediate

`define ALU_ADD 4'b0001 // Add
`define ALU_SUB 4'b0010 // Subtract
`define ALU_SHL 4'b0101 // Shift Left
`define ALU_SHAR 4'b0110 // Arithmetic Shift Right 
`define ALU_SHLR 4'b0111 // Logical Shift Right
`define ALU_RL 4'b1000 // Rotate Left
`define ALU_RR 4'b1001 // Rotate Right
`define ALU_AND 4'b1011 // AND
`define ALU_OR 4'b1100 // OR
`define ALU_XOR 4'b1101 // XOR
`define ALU_NOT 4'b1110 // NOT
`define ALU_MULT 4'b1111 // Multiply

module Decoder_OP(instr, unary, imm, aluop, setcc, rD, rA, rB, immB, wben);
	input [15:0] instr;
	output unary;
	output imm;
	output [3:0] aluop; // ADD, SUB, SHL, SHLR, SHAR, RL, RR, AND, OR, NOT, MULT (4 bits for 11 ops)
	output setcc;
	output [2:0] rD;
	output [2:0] rA;
	output [2:0] rB;
	output [3:0] immB;
	output wben;
	
	wire [4:0] opcode_i;
	reg unary;
	reg imm;
	reg [3:0] aluop;
	reg setcc;
	reg [2:0] rD;
	reg [2:0] rA;
	reg [2:0] rB;
	reg [3:0] immB;
	reg wben;
	
	assign opcode_i = {instr[15:12], instr[11]}; // {opcode, imm}
	
	always @(opcode_i or instr)
		case (opcode_i)
			`OP_ADD: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} = 
				{1'b0, 1'b0, `ALU_ADD, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_ADDI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} = 
				{1'b0, 1'b1, `ALU_ADD, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_MOV: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b1, 1'b0, `ALU_ADD, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_MOVI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b1, 1'b1, `ALU_ADD, instr[10], instr[9:7], 3'bx, 3'bx, instr[3:0], 1'b1};

			`OP_SUB: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_SUB, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_SUBI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_SUB, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};				

			`OP_SHL: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_SHL, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_SHLI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_SHL, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_SHAR: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_SHAR, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_SHARI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_SHAR, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_SHLR: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_SHLR, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_SHLRI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_SHLR, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_RL: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_RL, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_RLI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_RL, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_RR: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_RR, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_RRI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_RR, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};	
	
			`OP_AND: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_AND, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_ANDI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_AND, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
	
			`OP_OR: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_OR, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_ORI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_OR, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};
				
			`OP_NOT: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_NOT, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
				
			`OP_MULT: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b0, `ALU_MULT, instr[10], instr[9:7], instr[6:4], instr[3:1], 4'bx, 1'b1};
			`OP_MULTI: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1'b0, 1'b1, `ALU_MULT, instr[10], instr[9:7], instr[6:4], 3'bx, instr[3:0], 1'b1};			
		endcase
endmodule 