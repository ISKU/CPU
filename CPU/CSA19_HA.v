// 19bit Carry Save Adder (using Half Adder)
module CSA19_HA (cout, sum, a, b);
	input [18:0] a; // 19bit 입력 a, b
	input [18:0] b;
	output [18:0] cout, sum; // 19bit carry, sum
	
	HA hadd18(cout[18], sum[18], a[18], b[18]);	
	HA hadd17(cout[17], sum[17], a[17], b[17]);
	HA hadd16(cout[16], sum[16], a[16], b[16]);	
	HA hadd15(cout[15], sum[15], a[15], b[15]);
	HA hadd14(cout[14], sum[14], a[14], b[14]);
	HA hadd13(cout[13], sum[13], a[13], b[13]);
	HA hadd12(cout[12], sum[12], a[12], b[12]);
	HA hadd11(cout[11], sum[11], a[11], b[11]);
	HA hadd10(cout[10], sum[10], a[10], b[10]);
	HA hadd9(cout[9], sum[9], a[9], b[9]);
	HA hadd8(cout[8], sum[8], a[8], b[8]);
	HA hadd7(cout[7], sum[7], a[7], b[7]);
	HA hadd6(cout[6], sum[6], a[6], b[6]);
	HA hadd5(cout[5], sum[5], a[5], b[5]);
	HA hadd4(cout[4], sum[4], a[4], b[4]);
	HA hadd3(cout[3], sum[3], a[3], b[3]);
	HA hadd2(cout[2], sum[2], a[2], b[2]);
	HA hadd1(cout[1], sum[1], a[1], b[1]);
	HA hadd0(cout[0], sum[0], a[0], b[0]);
	// 연산의 입력이 2개일 때 Full Adder 대신 Half Adder를 사용
	// Booth Multiplier의 partial product의 가장 마지막 덧셈에 사용된다.
endmodule 