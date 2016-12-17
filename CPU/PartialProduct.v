`define BOOTH_m2A 3'd1
`define BOOTH_mA 3'd2
`define BOOTH_0 3'd3
`define BOOTH_pA 3'd4
`define BOOTH_p2A 3'd5

module PartialProduct(dout, sign, sel, din);
	input [15:0] din; // x * y 의 x값
	input [2:0] sel; // BoothEncoding 결과 값
	output [16:0] dout; // BoothEncoding 결과 값에 따라 partial product가 결정됨
	output sign; // 부호비트
	
	reg [16:0] dout;
	reg sign;
	
	// BoothEncoder로 얻어진 결과 값과 x값을 곱하여 얻어지는 결과를 반환 
	always @(din or sel) begin
		casex(sel)
			`BOOTH_m2A: begin dout = ~{din, 1'b0}; sign = 1'b1; end
			`BOOTH_mA: begin dout = ~{din[15], din}; sign = 1'b1; end
			`BOOTH_0: begin dout = 17'b0; sign = 1'b0; end
			`BOOTH_pA: begin dout = {din[15], din}; sign = 1'b0; end
			`BOOTH_p2A: begin dout = {din, 1'b0}; sign = 1'b0; end
			default : begin dout = 17'bX; sign = 1'bX; end
		endcase
	end
endmodule 