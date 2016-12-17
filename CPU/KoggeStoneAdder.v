module KoggeStoneAdder (c16, sum, x, y, c0);
	input [15:0] x, y; // input x, y
	input c0; // carry in
	output [15:0] sum; // result x + y
	output c16; // carry out
	
	wire [15:0] PZ, GZ; // group P, G (input cell)
	wire [14:0] PA, GA;
	wire [13:0] PB, GB;
	wire [11:0] PC, GC;
	wire [7:0] PD, GD; // black cell
	wire [16:1] carry; // carry1 ~ carry16

	// input stage: Pre-calculation of P_i, G_i terms
	// x_i와 y_i의 각 1비트에 대한 P, G를 구함
	InputCell level_Z0(PZ[0], GZ[0], x[0], y[0]);
	InputCell level_Z1(PZ[1], GZ[1], x[1], y[1]);
	InputCell level_Z2(PZ[2], GZ[2], x[2], y[2]);
	InputCell level_Z3(PZ[3], GZ[3], x[3], y[3]);
	InputCell level_Z4(PZ[4], GZ[4], x[4], y[4]);
	InputCell level_Z5(PZ[5], GZ[5], x[5], y[5]);
	InputCell level_Z6(PZ[6], GZ[6], x[6], y[6]);
	InputCell level_Z7(PZ[7], GZ[7], x[7], y[7]);
	InputCell level_Z8(PZ[8], GZ[8], x[8], y[8]);
	InputCell level_Z9(PZ[9], GZ[9], x[9], y[9]);
	InputCell level_Z10(PZ[10], GZ[10], x[10], y[10]);
	InputCell level_Z11(PZ[11], GZ[11], x[11], y[11]);
	InputCell level_Z12(PZ[12], GZ[12], x[12], y[12]);
	InputCell level_Z13(PZ[13], GZ[13], x[13], y[13]);
	InputCell level_Z14(PZ[14], GZ[14], x[14], y[14]);
	InputCell level_Z15(PZ[15], GZ[15], x[15], y[15]);
	
	// Carry lookahead tree: level-1
	// 첫번째 레벨의 Black Cell 그룹 P, G를 구한다.
	BlackCell level_A0(PA[0], GA[0], PZ[1], GZ[1], PZ[0], GZ[0]);
	BlackCell level_A1(PA[1], GA[1], PZ[2], GZ[2], PZ[1], GZ[1]);
	BlackCell level_A2(PA[2], GA[2], PZ[3], GZ[3], PZ[2], GZ[2]);
	BlackCell level_A3(PA[3], GA[3], PZ[4], GZ[4], PZ[3], GZ[3]);
	BlackCell level_A4(PA[4], GA[4], PZ[5], GZ[5], PZ[4], GZ[4]);
	BlackCell level_A5(PA[5], GA[5], PZ[6], GZ[6], PZ[5], GZ[5]);
	BlackCell level_A6(PA[6], GA[6], PZ[7], GZ[7], PZ[6], GZ[6]);
	BlackCell level_A7(PA[7], GA[7], PZ[8], GZ[8], PZ[7], GZ[7]);
	BlackCell level_A8(PA[8], GA[8], PZ[9], GZ[9], PZ[8], GZ[8]);
	BlackCell level_A9(PA[9], GA[9], PZ[10], GZ[10], PZ[9], GZ[9]);
	BlackCell level_A10(PA[10], GA[10], PZ[11], GZ[11], PZ[10], GZ[10]);
	BlackCell level_A11(PA[11], GA[11], PZ[12], GZ[12], PZ[11], GZ[11]);
	BlackCell level_A12(PA[12], GA[12], PZ[13], GZ[13], PZ[12], GZ[12]);
	BlackCell level_A13(PA[13], GA[13], PZ[14], GZ[14], PZ[13], GZ[13]);
	BlackCell level_A14(PA[14], GA[14], PZ[15], GZ[15], PZ[14], GZ[14]);
	
	// Carry lookahead tree: level-2
	// 두번째 레벨의 Black Cell 그룹 P, G를 구한다.
	BlackCell level_B0(PB[0], GB[0], PA[1], GA[1], PZ[0], GZ[0]);
	BlackCell level_B1(PB[1], GB[1], PA[2], GA[2], PA[0], GA[0]);
	BlackCell level_B2(PB[2], GB[2], PA[3], GA[3], PA[1], GA[1]);
	BlackCell level_B3(PB[3], GB[3], PA[4], GA[4], PA[2], GA[2]);
	BlackCell level_B4(PB[4], GB[4], PA[5], GA[5], PA[3], GA[3]);
	BlackCell level_B5(PB[5], GB[5], PA[6], GA[6], PA[4], GA[4]);
	BlackCell level_B6(PB[6], GB[6], PA[7], GA[7], PA[5], GA[5]);
	BlackCell level_B7(PB[7], GB[7], PA[8], GA[8], PA[6], GA[6]);
	BlackCell level_B8(PB[8], GB[8], PA[9], GA[9], PA[7], GA[7]);
	BlackCell level_B9(PB[9], GB[9], PA[10], GA[10], PA[8], GA[8]);
	BlackCell level_B10(PB[10], GB[10], PA[11], GA[11], PA[9], GA[9]);
	BlackCell level_B11(PB[11], GB[11], PA[12], GA[12], PA[10], GA[10]);
	BlackCell level_B12(PB[12], GB[12], PA[13], GA[13], PA[11], GA[11]);
	BlackCell level_B13(PB[13], GB[13], PA[14], GA[14], PA[12], GA[12]);
	
	// Carry lookahead tree: level-3
	// 세번째 레벨의 Black Cell 그룹 P, G를 구한다.
	BlackCell level_C0(PC[0], GC[0], PB[2], GB[2], PZ[0], GZ[0]);
	BlackCell level_C1(PC[1], GC[1], PB[3], GB[3], PA[0], GA[0]);
	BlackCell level_C2(PC[2], GC[2], PB[4], GB[4], PB[0], GB[0]);
	BlackCell level_C3(PC[3], GC[3], PB[5], GB[5], PB[1], GB[1]);
	BlackCell level_C4(PC[4], GC[4], PB[6], GB[6], PB[2], GB[2]);
	BlackCell level_C5(PC[5], GC[5], PB[7], GB[7], PB[3], GB[3]);
	BlackCell level_C6(PC[6], GC[6], PB[8], GB[8], PB[4], GB[4]);
	BlackCell level_C7(PC[7], GC[7], PB[9], GB[9], PB[5], GB[5]);
	BlackCell level_C8(PC[8], GC[8], PB[10], GB[10], PB[6], GB[6]);
	BlackCell level_C9(PC[9], GC[9], PB[11], GB[11], PB[7], GB[7]);
	BlackCell level_C10(PC[10], GC[10], PB[12], GB[12], PB[8], GB[8]);
	BlackCell level_C11(PC[11], GC[11], PB[13], GB[13], PB[9], GB[9]);
	
	// Carry lookahead tree: level-4
	// 네번째 레벨의 Black Cell 그룹 P, G를 구한다.
	BlackCell level_D0(PD[0], GD[0], PC[4], GC[4], PZ[0], GZ[0]);
	BlackCell level_D1(PD[1], GD[1], PC[5], GC[5], PA[0], GA[0]);
	BlackCell level_D2(PD[2], GD[2], PC[6], GC[6], PB[0], GB[0]);
	BlackCell level_D3(PD[3], GD[3], PC[7], GC[7], PB[1], GB[1]);
	BlackCell level_D4(PD[4], GD[4], PC[8], GC[8], PC[0], GC[0]);
	BlackCell level_D5(PD[5], GD[5], PC[9], GC[9], PC[1], GC[1]);
	BlackCell level_D6(PD[6], GD[6], PC[10], GC[10], PC[2], GC[2]);
	BlackCell level_D7(PD[7], GD[7], PC[11], GC[11], PC[3], GC[3]);

	// Calculation of the carries
	// Black Cell로 부터 그룹 P, G를 구한 결과를 가지고 Lookahead carry를 구한다.
	CarryCell carry1(carry[1], c0, PZ[0], GZ[0]);
	CarryCell carry2(carry[2], c0, PA[0], GA[0]);
	CarryCell carry3(carry[3], c0, PB[0], GB[0]);
	CarryCell carry4(carry[4], c0, PB[1], GB[1]);
	CarryCell carry5(carry[5], c0, PC[0], GC[0]);
	CarryCell carry6(carry[6], c0, PC[1], GC[1]);
	CarryCell carry7(carry[7], c0, PC[2], GC[2]);
	CarryCell carry8(carry[8], c0, PC[3], GC[3]);
	CarryCell carry9(carry[9], c0, PD[0], GD[0]);
	CarryCell carry10(carry[10], c0, PD[1], GD[1]);
	CarryCell carry11(carry[11], c0, PD[2], GD[2]);
	CarryCell carry12(carry[12], c0, PD[3], GD[3]);
	CarryCell carry13(carry[13], c0, PD[4], GD[4]);
	CarryCell carry14(carry[14], c0, PD[5], GD[5]);
	CarryCell carry15(carry[15], c0, PD[6], GD[6]);
	CarryCell carry16(carry[16], c0, PD[7], GD[7]);
	assign c16 = carry[16];
	
	// Generate the sum
	// 최종적으로 x + y의 값을 계산한다.
	assign sum[0] = c0 ^ PZ[0];
	assign sum[1] = carry[1] ^ PZ[1];
	assign sum[2] = carry[2] ^ PZ[2];
	assign sum[3] = carry[3] ^ PZ[3];
	assign sum[4] = carry[4] ^ PZ[4];
	assign sum[5] = carry[5] ^ PZ[5];
	assign sum[6] = carry[6] ^ PZ[6];
	assign sum[7] = carry[7] ^ PZ[7];
	assign sum[8] = carry[8] ^ PZ[8];
	assign sum[9] = carry[9] ^ PZ[9];
	assign sum[10] = carry[10] ^ PZ[10];
	assign sum[11] = carry[11] ^ PZ[11];
	assign sum[12] = carry[12] ^ PZ[12];
	assign sum[13] = carry[13] ^ PZ[13];
	assign sum[14] = carry[14] ^ PZ[14];
	assign sum[15] = carry[15] ^ PZ[15];
	
endmodule 