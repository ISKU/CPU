module Shifter16_LR(out, shift, lr, in);
	input [3:0] shift; // shift할 bit 개수 체크 (4bit: 1~16bit shift)
	input lr; // left 또는 right shift 방향 결정 (1: left, 0: right)
	input [15:0] in; // 16bit 입력값
	output [15:0] out; // 16bit shift된 출력
	
	wire [15:0] ta; // 1bit shift 결과
	wire [15:0] tb; // 2bit shift 결과
	wire [15:0] tc; // 4bit shift 결과
	wire [15:0] td; // 8bit shitf 결과

	// left or right shift
	assign ta = shift[0] ? (lr ? {in[14:0], 1'b0} : {1'b0, in[15:1]}) : in; // <<1, >>1
	assign tb = shift[1] ? (lr ? {ta[13:0], 2'b0} : {2'b0, ta[15:2]}) : ta; // <<2, >>2
	assign tc = shift[2] ? (lr ? {tb[11:0], 4'b0} : {4'b0, tb[15:4]}) : tb; // <<4, >>4
	assign td = shift[3] ? (lr ? {tc[7:0], 8'b0} : {8'b0, tc[15:8]}) : tc; // <<8, >>8
	assign out = td;
endmodule 