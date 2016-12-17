module BoothMultiplier(cout, z16, x, y);
	input [15:0] x; 
	input [15:0] y; // input 16bit x, y (X * y)
	output [15:0] z16; // output z (32bit -> reduce 16bit)
	output cout; // carry over flow
	
	wire [31:0] z;
	
	wire [2:0] sel1;
	wire [2:0] sel2;
	wire [2:0] sel3;
	wire [2:0] sel4;
	wire [2:0] sel5;
	wire [2:0] sel6;
	wire [2:0] sel7;
	wire [2:0] sel8; // partial product에 생기는 booth encoding 정보 저장
	
	wire sign1;
	wire sign2;
	wire sign3;
	wire sign4;
	wire sign5;
	wire sign6;
	wire sign7;
	wire sign8; // 각 partial product의 부호 저장
	
	wire [16:0] partial1;
	wire [16:0] partial2;
	wire [16:0] partial3;
	wire [16:0] partial4;
	wire [16:0] partial5;
	wire [16:0] partial6;
	wire [16:0] partial7;
	wire [16:0] partial8; // 8개의 partial product
	
	wire [19:0] sum1;
	wire [19:0] sum2;
	wire [19:0] sum3;
	wire [19:0] sum4;
	wire [19:0] sum5;
	wire [19:0] sum6;
	wire [18:0] sum7; // 8개의 partial product를 더하면서 생기는 CSA의 sum
	
	wire [19:0]carry1;
	wire [19:0]carry2;
	wire [19:0]carry3;
	wire [19:0]carry4;
	wire [19:0]carry5;
	wire [19:0]carry6;
	wire [18:0]carry7; // 8개의 partial product를 더하면서 생기는 CSA의 carry
	wire realcout;
	
	// Booth Encoding을 위해 y를 1에서 16bit까지 3비트씩 참조하여 encoding 결과를 sel 변수에 담는다.
	BoothEncoder booth1(sel1, {y[1:0], 1'b0});
	BoothEncoder booth2(sel2, y[3:1]);
	BoothEncoder booth3(sel3, y[5:3]);
	BoothEncoder booth4(sel4, y[7:5]);
	BoothEncoder booth5(sel5, y[9:7]);
	BoothEncoder booth6(sel6, y[11:9]);
	BoothEncoder booth7(sel7, y[13:11]);
	BoothEncoder booth8(sel8, y[15:13]);
	
	// Booth Encoding을 통해 반환된 sel 변수를 이용하여 x와의 곱을 통해 partial product와 sign을 생성한다.
	PartialProduct level_1(partial1, sign1, sel1, x);
	PartialProduct level_2(partial2, sign2, sel2, x);
	PartialProduct level_3(partial3, sign3, sel3, x);
	PartialProduct level_4(partial4, sign4, sel4, x);
	PartialProduct level_5(partial5, sign5, sel5, x);
	PartialProduct level_6(partial6, sign6, sel6, x);
	PartialProduct level_7(partial7, sign7, sel7, x);
	PartialProduct level_8(partial8, sign8, sel8, x);
	
	// Carry Save Adders, partial product를 모두 더하는 과정
	// level 1, 2, 3의 partial product를 20bit씩 더한다.
	CSA20 csa0(
		carry1,
		sum1,
		({3'b0, ~partial1[16], partial1[16], partial1[16:2]}),
		({2'b0, 1'b1, ~partial2[16], partial2[15:0]}),
		({1'b1, ~partial3[16], partial3[15:0], 2'b0})
	);
	
	// level4의 partial product를 위 level의 carry와 sum을 CSA로 더한다.
	CSA20 csa1(
		carry2,
		sum2,
		{2'b0, sum1[19:2]},
		{1'b0, carry1[19:2], sign3},
		{1'b1, ~partial4[16], partial4[15:0], 2'b0}
	);
	
	// level5의 partial product를 위 level의 carry와 sum을 CSA로 더한다.
	CSA20 csa2(
		carry3,
		sum3,
		{2'b0, sum2[19:2]},
		{1'b0, carry2[19:2], sign4},
		{1'b1, ~partial5[16], partial5[15:0], 2'b0}
	);
	
	// level6의 partial product를 위 level의 carry와 sum을 CSA로 더한다.
	CSA20 csa3(
		carry4,
		sum4,
		{2'b0, sum3[19:2]},
		{1'b0, carry3[19:2], sign5},
		{1'b1, ~partial6[16], partial6[15:0], 2'b0}
	);
	
	// level7의 partial product를 위 level의 carry와 sum을 CSA로 더한다.
	CSA20 csa4(
		carry5,
		sum5,
		{2'b0, sum4[19:2]},
		{1'b0, carry4[19:2], sign6},
		{1'b1, ~partial7[16], partial7[15:0], 2'b0}
	);

	// level8의 partial product를 위 level의 carry와 sum을 CSA로 더한다.	
	CSA20 csa5(
		carry6,
		sum6,
		{2'b0, sum5[19:2]},
		{1'b0, carry5[19:2], sign7},
		{1'b1, ~partial8[16], partial8[15:0], 2'b0}
	);

	// 마지막 level의 sign 비트와 위 level의 carry sum을 Half Adder를 이용한 CSA로 더한다. 
	CSA19_HA csa6(
		carry7,
		sum7,
		{1'b0, sum6[19:2]},
		{carry6[19:2], sign8}
	);
	
	// 위 모든 level의 CSA로 더해진 결과를 32bit Ripple Carry Adder를 사용하여 x*y의 결과를 얻는다. 
	RCA32 cpa0(
		realcout,
		z,
		{sum7[17:0], sum6[1:0], sum5[1:0], sum4[1:0], sum3[1:0], sum2[1:0], sum1[1:0], partial1[1:0]},
		{carry7[16:0], carry6[1:0], carry5[1:0], carry4[1:0], carry3[1:0], carry2[1:0], carry1[1:0], sign2, 1'b0, sign1},
		1'b0
	);
	
	assign cout = z[16];
	assign z16 = z[15:0];
endmodule 