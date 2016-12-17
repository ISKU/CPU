`define READ 1'b0
`define WRITE 1'b1

module CPU (clk, nRESET);
	input clk; // Clock
	input nRESET; // RESET
	
	reg [15:0] pc; // Program Counter 주소
	reg [3:0] cc; // NZCV
	wire [15:0] instr; // Instruction

	wire [3:0] aluop; // OP Code
	wire unary; // unary
	wire imm; // immediate
	wire setcc; // Set NZCV
	wire wben; // Set Write Back
	
	wire [2:0] rD, rA, rB; // Dest Register, read A, B Register
	wire [3:0] immB; // Instruction으로부터 읽은 immediate 값
	
	wire [15:0] valA, valB, svalA, svalB, valE; // 계산을 수행할 값 A, B
	wire [3:0] NZCV; // NZCV

	/* PC Register */
	always @(posedge clk or negedge nRESET)
		if (!nRESET) 
			pc <= 16'b0;
		else 
			pc <= pc + 2;

	/* Instruction Memory */
	Memory imem(clk, `READ, pc, instr);
	
	/* Instruction Decoder */
	Decoder_OP idec(instr, unary, imm, aluop, setcc, rD, rA, rB, immB, wben);

	/* Register File */
	RegisterFile ireg_file(clk, nRESET, wben, rD, valE, rA, rB, valA, valB);

	/* ALU */
	assign svalA = (unary == 1'b1) ? 16'b0 : valA;
	assign svalB = (imm == 1'b1) ? {{12{immB[3]}}, immB} : valB; // sign ext
	ALU ialu(valE, NZCV, svalA, svalB, aluop);

	/* Condition code Register */
	always @(posedge clk or negedge nRESET)
		if (!nRESET) 
			cc <= 4'b0;
		else if(setcc) 
			cc <= NZCV;
		else
			cc <= 4'b0;
endmodule 