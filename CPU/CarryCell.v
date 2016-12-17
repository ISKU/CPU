module CarryCell(ci, c0, Pi0, Gi0);
	input Pi0, Gi0, c0;
	output ci;
	
	assign ci = Gi0 | (Pi0 & c0);
	// c_i+1 = G_i:0 + P_i:0 and c0
endmodule 