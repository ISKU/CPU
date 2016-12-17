module BlackCell(Pij, Gij, Pim, Gim, Pmj, Gmj);
	input Pim, Gim, Pmj, Gmj;
	output Pij, Gij;
	
	assign Pij = Pim & Pmj;
	assign Gij = Gim | (Pim & Gmj);
	// (P_i:j, G_i:j) = (P_i:m and P_m-1:j, G_i:m + P_i:m and G_m-1:j)
endmodule 