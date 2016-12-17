module RCA32(cout, sum, x, y, cin);
	input [31:0] x, y; // 32bit input
	input cin; // 0번재 FA의 들어오는 Carry의 초기값
	output [31:0] sum; // x+y 더한 결과
	output cout; // 마지막 FA의 Carry
	wire [30:0] c; // 각각의 FA의 Carry
	
	FA FA0(c[0], sum[0], x[0], y[0], cin);
	FA FA1(c[1], sum[1], x[1], y[1], c[0]);
	FA FA2(c[2], sum[2], x[2], y[2], c[1]);
	FA FA3(c[3], sum[3], x[3], y[3], c[2]);
	FA FA4(c[4], sum[4], x[4], y[4], c[3]);
	FA FA5(c[5], sum[5], x[5], y[5], c[4]);
	FA FA6(c[6], sum[6], x[6], y[6], c[5]);
	FA FA7(c[7], sum[7], x[7], y[7], c[6]);
	FA FA8(c[8], sum[8], x[8], y[8], c[7]);
	FA FA9(c[9], sum[9], x[9], y[9], c[8]);
	FA FA10(c[10], sum[10], x[10], y[10], c[9]);
	FA FA11(c[11], sum[11], x[11], y[11], c[10]);
	FA FA12(c[12], sum[12], x[12], y[12], c[11]);
	FA FA13(c[13], sum[13], x[13], y[13], c[12]);
	FA FA14(c[14], sum[14], x[14], y[14], c[13]);
	FA FA15(c[15], sum[15], x[15], y[15], c[14]);
	FA FA16(c[16], sum[16], x[16], y[16], c[15]);
	FA FA17(c[17], sum[17], x[17], y[17], c[16]);
	FA FA18(c[18], sum[18], x[18], y[18], c[17]);
	FA FA19(c[19], sum[19], x[19], y[19], c[18]);
	FA FA20(c[20], sum[20], x[20], y[20], c[19]);
	FA FA21(c[21], sum[21], x[21], y[21], c[20]);
	FA FA22(c[22], sum[22], x[22], y[22], c[21]);
	FA FA23(c[23], sum[23], x[23], y[23], c[22]);
	FA FA24(c[24], sum[24], x[24], y[24], c[23]);
	FA FA25(c[25], sum[25], x[25], y[25], c[24]);
	FA FA26(c[26], sum[26], x[26], y[26], c[25]);
	FA FA27(c[27], sum[27], x[27], y[27], c[26]);
	FA FA28(c[28], sum[28], x[28], y[28], c[27]);
	FA FA29(c[29], sum[29], x[29], y[29], c[28]);
	FA FA30(c[30], sum[30], x[30], y[30], c[29]);
	FA FA31(cout, sum[31], x[31], y[31], c[30]);
	// 1bit 더하기를 하는 FA 32개를 이어 붙여 32bit 덧셈을 할 수 있다.
	// cin은 0번째 FA의 들어오는 Carry이며, cout은 마지막 FA의 Carry이다.
	// 각 FA가 연산한 결과는 sum으로 저장되고, carry는 다음 FA로 넘겨준다.
endmodule 