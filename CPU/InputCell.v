module InputCell(P, G, a, b);
	input a, b;
	output P, G;
	
	assign P = a ^ b; // P_i = a xor b
	assign G = a & b; // G_i = a and b
endmodule 