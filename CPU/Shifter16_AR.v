module Shifter16_AR(out, shift, in);
	input [3:0] shift; // shift할 bit 개수 체크 (4bit: 1~16bit Arthmetic Shift)
	input [15:0] in; // 16bit 입력값
	output [15:0] out; // 16bit Arthmetic Shift 출력
	
	wire [15:0] ta; // 1bit Arthmetic Shift 결과
	wire [15:0] tb; // 2bit Arthmetic Shift 결과
	wire [15:0] tc; // 4bit Arthmetic Shift 결과
	wire [15:0] td; // 8bit Arthmetic Shift 결과

	// Arthmetic Shift Right
	assign ta = shift[0] ? ({in[15], in[15:1]}) : in; // <<1, >>1
	assign tb = shift[1] ? ({in[15], in[15], ta[15:2]}) : ta; // <<2, >>2
	assign tc = shift[2] ? ({in[15], in[15], in[15], in[15], tb[15:4]}) : tb; // <<4, >>4
	assign td = shift[3] ? ({in[15], in[15], in[15], in[15], in[15], in[15], in[15], in[15], tc[15:8]}) : tc; // <<8, >>8
	assign out = td;
endmodule 