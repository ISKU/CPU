// 20bit Carry Save Adder 
module CSA20 (cout, sum, a, b, c);
	input [19:0] a; // 20bit 입력 a, b, c
	input [19:0] b;
	input [19:0] c; 
	output [19:0] cout, sum; // carry와 sum이 각 20bit씩 save

	FA fadd19(cout[19], sum[19], a[19], b[19], c[19]);
	FA fadd18(cout[18], sum[18], a[18], b[18], c[18]);
	FA fadd17(cout[17], sum[17], a[17], b[17], c[17]);
	FA fadd16(cout[16], sum[16], a[16], b[16], c[16]);
	FA fadd15(cout[15], sum[15], a[15], b[15], c[15]);
	FA fadd14(cout[14], sum[14], a[14], b[14], c[14]);
	FA fadd13(cout[13], sum[13], a[13], b[13], c[13]);
	FA fadd12(cout[12], sum[12], a[12], b[12], c[12]);
	FA fadd11(cout[11], sum[11], a[11], b[11], c[11]);
	FA fadd10(cout[10], sum[10], a[10], b[10], c[10]);
	FA fadd9(cout[9], sum[9], a[9], b[9], c[9]);
	FA fadd8(cout[8], sum[8], a[8], b[8], c[8]);
	FA fadd7(cout[7], sum[7], a[7], b[7], c[7]);
	FA fadd6(cout[6], sum[6], a[6], b[6], c[6]);
	FA fadd5(cout[5], sum[5], a[5], b[5], c[5]);
	FA fadd4(cout[4], sum[4], a[4], b[4], c[4]);
	FA fadd3(cout[3], sum[3], a[3], b[3], c[3]);
	FA fadd2(cout[2], sum[2], a[2], b[2], c[2]);
	FA fadd1(cout[1], sum[1], a[1], b[1], c[1]);
	FA fadd0(cout[0], sum[0], a[0], b[0], c[0]);
	// carry와 sum의 결과를 바로 계산하지 않고 다음 Adder에게 값을 넘기기 위해 사용
endmodule 