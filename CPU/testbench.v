module testbench;
	reg clk, nRESET;

	/* clock generator */
	always
		#2.5 clk = ~clk;

	/* tiny cpu */
	CPU icpu(clk, nRESET);

	initial begin
		$readmenh("machine_code.txt", icpu.imem); // program code given in txt file

		clk = 1'b0;
		nRESET = 1'b1;
		#5 nRESET = 1'b0;
		#5 nRESET = 1'b1;

		#50000
		$finish;
	end
endmodule 