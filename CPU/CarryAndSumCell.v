module CarryAndSumCell(ci, c0, Pi0, Gi0);
	input Pi0, Gi0, c0;
	output ci;
	
	assign ci = Gi0 | (Pi0 & c0);
endmodule 