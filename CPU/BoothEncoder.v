`define BOOTH_m2A 3'd1
`define BOOTH_mA 3'd2
`define BOOTH_0 3'd3
`define BOOTH_pA 3'd4
`define BOOTH_p2A 3'd5

module BoothEncoder(sel, data);
	input [2:0] data; // 3비트 참조 데이터
	output [2:0] sel; // Booth Encoding 결과
	reg [2:0] sel;
	
	// 입력 데이터의 3비트씩을 참조하여 Booth Encoding 결과를 반환
	always @(data) begin
		case(data)
			3'b000 : begin sel = `BOOTH_0; end // 00
			3'b010 : begin sel = `BOOTH_pA; end //01
			3'b100 : begin sel = `BOOTH_m2A; end // -10
			3'b110 : begin sel = `BOOTH_mA; end // 0-1
			3'b001 : begin sel = `BOOTH_pA; end // 0 1
			3'b011 : begin sel = `BOOTH_p2A; end // 10
			3'b101 : begin sel = `BOOTH_mA; end // 0-1
			3'b111 : begin sel = `BOOTH_0; end // 00
		endcase
	end
endmodule 