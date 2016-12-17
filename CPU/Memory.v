`define READ 1'b0
`define WRITE 1'b1

/* simulation model; not for synthesis */
module Memory (clk, op, addr, data);
	input clk;
	input op; // READ or WRITE
	input [15:0] addr;
	output [15:0] data;

	/* array in Verilog; simulation only */
	reg [7:0] mem [65535:0]; // 65536 entries of 8-bit entry
	
	/* Read */
	assign data = {mem[addr+1], mem[addr]}; // 16-bit little endian
	
	/* Write */
	always @(posedge clk)
		if (op == `WRITE) 
			{mem[addr+1], mem[addr]} <= data;
endmodule 