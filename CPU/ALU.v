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

module ALU (result, cc, valA, valB, aluop);
	input [15:0] valA; // input A
	input [15:0] valB; // input B
	input [3:0] aluop; // ALU Operation code (12개)
	wire sub; // 빼기 옵션
	
	output [3:0] cc; // N, Z, C, V
	output [15:0] result; // output
	
	wire [15:0] and16b, or16b, not16b, xor16b; // and, or, not, xor
	wire [15:0] shift_out, arithmetic_out, rotate_out; // shift, rotate
	wire [15:0] add_out, mul_out, svalB; // add, sub, multiply 
	
	wire [15:0] result;
	wire [3:0] cc;
	wire shift_co, add_co, mul_co; // shift, add, multiply carry overflow
	wire shift_LR, rotate_LR; // shift, rotate 왼쪽 오른쪽 선택
	wire N, Z, C, V; // N, Z, C, V
	
	// AND, OR, NOT, XOR
	assign and16b = valA & valB; // valA and valB
	assign or16b = valA | valB; // valA or valB
	assign not16b = ~valB; // not valB
	assign xor16b = valA ^ valB; // valA xor valB
	
	// Left Shifter Or Logical Shift Right
	assign shift_LR = 
		(aluop == `ALU_SHL) ? 1'b1 : // shift left
		(aluop == `ALU_SHLR) ? 1'b0 : 1'bx; // logical shift right
	Shifter16_LR myShifter(shift_out, valB, shift_LR, valA); // valA를 valB 만큼 Shift
	
	// Arithmetic Shift Right 
	Shifter16_AR myArithmeticShift(arithmetic_out, valB, valA); // valA를 valB만큼 Arithmetic Shift
	
	// Rotator
	assign rotate_LR = 
		(aluop == `ALU_RL) ? 1'b1 : // rotate left
		(aluop == `ALU_RR) ? 1'b0 : 1'bx; // rotate right
	Rotator16_LR myRotator(rotate_out, valB, rotate_LR, valA); // valA를 valB만큼 Rotate
	
	// 덧셈 or 뺄셈
	assign sub = (aluop == `ALU_SUB) ? 1'b1 : 1'b0;
	assign svalB = sub ? ~valB : valB; // 뺄셈일 경우 1의 보수를 취한다
	KoggeStoneAdder myAdder(add_co, add_out, valA, svalB, sub); // KoggeStoneAdder를 통한 덧셈 또는 뺄셈(1(sub)의 더하여 2의보수)

	// 곱셈
	BoothMultiplier myMultiplier(mul_co, mul_out, valA, valB);
	
	// 각각의 OPCODE에 대한 결과값 
	assign result =
		(aluop == `ALU_ADD) ? add_out :
		(aluop == `ALU_SUB) ? add_out :
		(aluop == `ALU_SHL) ? shift_out :
		(aluop == `ALU_SHAR) ? arithmetic_out :
		(aluop == `ALU_SHLR) ? shift_out :
		(aluop == `ALU_RL) ? rotate_out :
		(aluop == `ALU_RR) ? rotate_out :
		(aluop == `ALU_AND) ? and16b :
		(aluop == `ALU_OR) ? or16b :
		(aluop == `ALU_XOR) ? xor16b :
		(aluop == `ALU_NOT) ? not16b :
		(aluop == `ALU_MULT) ? mul_out : 16'bx;
	
	assign N = result[15]; // 최상위 비트로부터 Sign 확인
	assign Z = ~|result; // Zero 확인
	assign C = // Carry 확인
		(aluop == `ALU_ADD) ? add_co : // Add
		(aluop == `ALU_MULT) ? mul_co : // Multiply
		1'b0;
	assign V = // Overflow 확인
		(aluop == `ALU_SHL) ? 1'b1 : // shift left
		(aluop == `ALU_ADD) ? // Add
			(~valA[15] & ~svalB[15] & add_out[15]) | /* (-) + (-) = (+) */ 
			(valA[15] & svalB[15] & ~add_out[15]) : /* (+) + (+) = (-) */
		(aluop == `ALU_MULT) ? (valA[15] & valB[15]) : // Multiply
		1'b0;
	
	assign cc = {N, Z, C, V};
	
endmodule 