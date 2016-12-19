`define READ 1'b0
`define WRITE 1'b1

/* simulation model; not for synthesis */
module Memory (clk, op, addr, data);
	input clk;
	input op; // READ or WRITE
	input [15:0] addr;
	output [15:0] data;
	wire [15:0] data;

	/* array in Verilog; simulation only */
	reg [7:0] mem [0:1000]; // 1000 entries of 8-bit entry
	
	/* Read */
	assign data = {mem[addr], mem[addr+1]};
	
endmodule 